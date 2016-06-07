<?xml version="1.0" encoding="UTF-8"?>
<!--
    Create overview of installable products from a SWPM products.catalog.

    Example usage:
      xsltproc swpm-catalog.xsl products.catalog > xml/s4s_installation_product.xml
-->
<!DOCTYPE xsl:stylesheet [
]>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  exclude-result-prefixes="">

  <xsl:output method="xml" indent="yes" version="1.0" encoding="utf-8"/>

  <xsl:template match="*"/>

  <xsl:template match="/">
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE itemizedlist&gt;</xsl:text>
    <xsl:comment>This file was automatically generated from a SWPM products.catalog file.</xsl:comment>
    <xsl:if test="product-catalog/comment()[1]">
      <xsl:comment>
        <xsl:text>Creation date of the products.catalog file: </xsl:text>
        <xsl:value-of select="substring-after(product-catalog/comment()[1], 'Created on: ')"/>
        <xsl:text></xsl:text>
      </xsl:comment>
    </xsl:if>
    <xsl:apply-templates select="product-catalog/catalog"/>
  </xsl:template>

  <xsl:template match="/product-catalog/catalog">
    <d:itemizedlist version="5.0">
      <xsl:apply-templates select="components/display-name"/>
    </d:itemizedlist>
  </xsl:template>

  <xsl:template match="components/display-name">
    <xsl:variable name="text"
      select="translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ -', 'abcdefghijklmnopqrstuvwxyz')"/>
    <xsl:if test="$text != 'systemrename' and
                  $text != 'dualstacksplit' and
                  $text != 'genericoptions'">
      <d:listitem>
        <d:para>
          <xsl:value-of select="normalize-space(.)"/>
        </d:para>
      </d:listitem>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
