<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                xmlns:shibmeta="urn:mace:shibboleth:metadata:1.0"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
                xmlns:md="urn:oasis:names:tc:SAML:2.0:metadata"
                extension-element-prefixes="exsl"
                xmlns:shibmd="urn:mace:shibboleth:metadata:1.0">
  
  <xsl:output method="text"/>
  
  <xsl:template match="//ds:KeyInfo">
    <xsl:param name="prefix"/>
      <xsl:text>-----BEGIN CERTIFICATE-----&#x0a;</xsl:text>
      <xsl:value-of select="ds:X509Data/ds:X509Certificate/text()"/>
      <xsl:text>&#x0a;-----END CERTIFICATE-----&#x0a;</xsl:text>
  </xsl:template>

  <xsl:template match="text()"/>
  
</xsl:stylesheet>
