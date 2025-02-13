#!/usr/bin/env bash

prg=`basename $0`
dir=`dirname $0`
territory=""
environment="test"

usage () {
   echo "Usage: $prg -t <territory> [-c <connector url>] [-p <proxy url>] [-h] [-v]"
   echo "     Std in should be a cert"
   echo "       -t <territory>: A 2-letter ISO country code"
   echo "       -e <environment prod or test>"
   echo "       -h: Print this text"
}

while getopts 't:e:h' c; do
   case $c in
      t) territory="$OPTARG" ;;
      e) environment="$OPTARG" ;;
      h) usage; exit ;;
   esac
done

if [ ! -r ${environment}/${territory}.xml ]; then
  echo "Cant read ${environment}/${territory}.xml"
  exit
fi

cert=$(cat)

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

  <xsl:param name="cert"/>

  <xsl:template name="addCert">
     <xsl:param name="cert"/>
     <!--Added cert-->
     <ds:X509Certificate>$cert
        </ds:X509Certificate>
  </xsl:template>

  <xsl:template match="ser:MetadataList">
    <xsl:copy><xsl:copy-of select="@*"/><xsl:apply-templates/></xsl:copy>
  </xsl:template>

  <xsl:template match="ser:MetadataLocation">
    <xsl:copy><xsl:copy-of select="@*"/><xsl:apply-templates/></xsl:copy>
  </xsl:template>

  <xsl:template match="ser:Endpoint">
    <xsl:copy><xsl:copy-of select="@*"/><xsl:apply-templates/></xsl:copy>
  </xsl:template>

  <xsl:template match="ds:KeyInfo">
    <xsl:copy><xsl:copy-of select="@*"/><xsl:apply-templates/></xsl:copy>
  </xsl:template>

  <xsl:template match="ds:X509Data">
    <xsl:copy><xsl:copy-of select="@*"/><xsl:apply-templates/></xsl:copy>
  </xsl:template>

  <xsl:template match="ds:X509Certificate">
    <xsl:call-template name="addCert"><xsl:with-param name="cert">$cert</xsl:with-param></xsl:call-template>
    <xsl:copy><xsl:copy-of select="@*"/><xsl:apply-templates/></xsl:copy>
  </xsl:template>

  <xsl:template match="@*"><xsl:copy/></xsl:template>
  <xsl:template match="*"></xsl:template>
</xsl:stylesheet>
EOF

xsltproc --stringparam hidden $hidden --xinclude $s ${environment}/${territory}.xml | xmllint --format --nsclean - > ${environment}/${territory}.new
mv ${environment}/${territory}.new ${environment}/${territory}.xml

rm -f $s 
