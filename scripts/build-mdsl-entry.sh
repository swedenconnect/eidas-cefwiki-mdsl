#!/usr/bin/env bash

prg=`basename $0`
dir=`dirname $0`
territory=""
connector=""
proxy=""
hidden="true"

usage () {
   echo "Usage: $prg -t <territory> [-c <connector url>] [-p <proxy url>] [-h] [-v]"
   echo "       -t <territory>: A 2-letter ISO country code"
   echo "       -c <url>: The connector URL (possibly empty)"
   echo "       -p <url>: The proxy service URL (possibly empty)"
   echo "       -h: Print this text"
   echo "       -v: Make visible - include endpoints in discovery (HideFromDiscovery=\"false\")"
}

while getopts 't:c:p:hv' c; do
   case $c in
      t) territory="$OPTARG" ;;
      c) connector="$OPTARG" ;;
      p) proxy="$OPTARG" ;;
      v) hidden="false" ;;
      h) usage; exit ;;
   esac
done

x=`mktemp`
cat>$x<<EOF
<?xml version="1.0"?>
<ser:MetadataList xmlns:xi="http://www.w3.org/2001/XInclude" xmlns:ser="http://eidas.europa.eu/metadata/servicelist" Territory="$territory">
EOF

# Some contries blocks curl and wget
USER_AGENT='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.3 Safari/605.1.15'

if [ "x$connector" != "x" ]; then
c_xml=`mktemp`
wget -U "${USER_AGENT}" --timeout=3 --tries=2 --no-check-certificate -qO$c_xml $connector && echo "<xi:include href=\"$c_xml\"/>" >> $x
fi

if [ "x$proxy" != "x" ]; then
p_xml=`mktemp`
wget -U "${USER_AGENT}" --timeout=3 --tries=2 --no-check-certificate -qO$p_xml $proxy && echo "<xi:include href=\"$p_xml\"/>" >> $x
fi

echo "</ser:MetadataList>" >> $x

s=`mktemp`
cat>$s<<EOF
<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xi="http://www.w3.org/2001/XInclude"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:shibmeta="urn:mace:shibboleth:metadata:1.0"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
                xmlns:md="urn:oasis:names:tc:SAML:2.0:metadata"
                xmlns:ser="http://eidas.europa.eu/metadata/servicelist"
                xmlns:exsl="http://exslt.org/common"
                extension-element-prefixes="exsl"
                xmlns:shibmd="urn:mace:shibboleth:metadata:1.0">

  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
  <xsl:param name="type"/>
  <xsl:param name="hidden"/>

  <xsl:template name="mdl">
     <xsl:param name="type"/>
     <ser:MetadataLocation>
        <xsl:attribute name="Location"><xsl:value-of select="@entityID"/></xsl:attribute>
        <ser:Endpoint>
           <xsl:attribute name="EndpointType"><xsl:value-of select="\$type"/></xsl:attribute>
           <xsl:attribute name="EntityID"><xsl:value-of select="@entityID"/></xsl:attribute>
           <xsl:if test="\$type = 'http://eidas.europa.eu/metadata/ept/ProxyService'">
              <xsl:attribute name="HideFromDiscovery"><xsl:value-of select="\$hidden"/></xsl:attribute>
           </xsl:if>
        </ser:Endpoint>
        <xsl:apply-templates/>
     </ser:MetadataLocation>
  </xsl:template>

  <xsl:template match="ser:MetadataList">
     <xsl:copy><xsl:copy-of select="@*"/><xsl:apply-templates/></xsl:copy>
  </xsl:template>

  <xsl:template match="ds:Signature">
    <xsl:apply-templates select="ds:KeyInfo"/>
  </xsl:template>

  <xsl:template match="ds:KeyInfo">
    <xsl:copy><xsl:apply-templates select="ds:X509Data"/></xsl:copy>
  </xsl:template>

  <xsl:template match="ds:X509Data">
    <xsl:copy><xsl:apply-templates select="ds:X509Certificate"/></xsl:copy>
  </xsl:template>

  <xsl:template match="ds:X509Certificate">
    <xsl:copy><xsl:copy-of select="text()"/></xsl:copy>
  </xsl:template>

EOF

if [ "x$proxy" != "x" ]; then
cat>>$s<<EOF
  <xsl:template match="md:EntityDescriptor[@entityID='$proxy']">
     <xsl:call-template name="mdl"><xsl:with-param name="type">http://eidas.europa.eu/metadata/ept/ProxyService</xsl:with-param></xsl:call-template>
  </xsl:template>
EOF
fi

if [ "x$connector" != "x" ]; then
cat>>$s<<EOF
  <xsl:template match="md:EntityDescriptor[@entityID='$connector']">
     <xsl:call-template name="mdl"><xsl:with-param name="type">http://eidas.europa.eu/metadata/ept/Connector</xsl:with-param></xsl:call-template>
  </xsl:template>
EOF
fi

cat>>$s<<EOF
  <xsl:template match="@*"><xsl:copy/></xsl:template>
  <xsl:template match="*"></xsl:template>
</xsl:stylesheet>
EOF

xsltproc --stringparam hidden $hidden --xinclude $s $x | xmllint --format --nsclean -


rm -f $x $s $c_xml $p_xml
