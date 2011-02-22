<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xhtml="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="xsl xs xhtml">

	<xsl:output 
		indent="yes"
		method="html" 
		encoding="utf-8"/>

  <xsl:template match="xhtml:html">
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text><xsl:value-of select="'&#xA;'"/>
    <html>
      <head>
        <title> - </title>
        <link rel="contents" href="index.html"/>
        <link rel="stylesheet" href="style.css"></link>
        <link rel="resources" href="resources.html"></link>
        <script src="treesaver-0.9.1.js"></script>
        <xsl:for-each select="xhtml:head/xhtml:link[@rel eq 'stylesheet']">
          <link rel="stylesheet" href="{@href}"></link>
        </xsl:for-each>
      </head>
      <body>
        <article>
          <xsl:apply-templates select="xhtml:body/child::node()"/>
        </article>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="/|comment()|processing-instruction()">
    <xsl:copy>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*">
    <xsl:element name="{local-name()}">
      <xsl:apply-templates select="@*|node()"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="@*">
    <xsl:attribute name="{local-name()}">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>

  <xsl:template match="xhtml:div[@class eq 'images']">
    <xsl:apply-templates select="xhtml:img"/>
  </xsl:template>

  <xsl:template match="xhtml:img">
    <xsl:variable name="images"><xsl:copy-of select="document(replace(@src, '\.(png|jpg|gif)', '.ixml'), .)"/></xsl:variable>
    <xsl:variable name="original"><xsl:value-of select="@src"/></xsl:variable>
    <xsl:message><xsl:copy-of select="$images"/><xsl:value-of select="base-uri($images)"/></xsl:message>
    <figure>
      <xsl:for-each select="$images/thumbs/file">
        <xsl:sort select="@width" order="descending" data-type="number"/>
        <xsl:choose>
          <xsl:when test="number(@width) le 280 and position() eq 1">
            <div class="images" data-minWidth="{@width}" data-minHeight="{@height}" data-sizes="single"><img src="{replace($original, $images/thumbs/@src, @src)}" width="{@width}" height="{@height}"/></div>
          </xsl:when>
          <xsl:when test="number(@width) le 600 and position() eq 1">
            <div class="images" data-minWidth="{@width}" data-minHeight="{@height}" data-sizes="double"><img src="{replace($original, $images/thumbs/@src, @src)}" width="{@width}" height="{@height}"/></div>
          </xsl:when>
          <xsl:when test="number(@width) le 280 and position() ne 1">
            <div class="images" data-minWidth="{@width}" data-minHeight="{@height}" data-sizes="single"><img data-src="{replace($original, $images/thumbs/@src, @src)}" width="{@width}" height="{@height}"/></div>
          </xsl:when>
          <xsl:when test="number(@width) le 600 and position() ne 1">
            <div class="images" data-minWidth="{@width}" data-minHeight="{@height}" data-sizes="double"><img data-src="{replace($original, $images/thumbs/@src, @src)}" width="{@width}" height="{@height}"/></div>
          </xsl:when>
          <xsl:otherwise>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </figure>
  </xsl:template>
</xsl:stylesheet>
