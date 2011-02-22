<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:opf="http://www.idpf.org/2007/opf"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:ncx="http://www.daisy.org/z3986/2005/ncx/"
  exclude-result-prefixes="xsl xs opf dc ncx">

	<xsl:output 
		indent="yes"
		method="html" 
		encoding="utf-8"/>

  <xsl:key name="id" match="opf:item" use="@id"/>
  <xsl:key name="src" match="ncx:content" use="@src"/>

  <xsl:variable name="ncx">
    <xsl:copy-of select="document(string(key('id', 'ncx')/@href), .)"/>
  </xsl:variable>

  <xsl:template match="opf:package">
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text><xsl:value-of select="'&#xA;'"/>
    <html>
      <head>
        <title><xsl:value-of select="$ncx/ncx:ncx/ncx:docTitle/ncx:text/text()"/> - <xsl:value-of select="$ncx/ncx:ncx/ncx:docAuthor/ncx:text/text()"/></title>
        <link rel="contents self" href="index.html"/>
        <link rel="stylesheet" href="style.css"></link>
        <link rel="resources" href="resources.html"></link>
        <script src="treesaver-0.9.1.js"></script>
      </head>
      <body>
        <article>
          <div itemscope="itemscope" data-properties="self">
            <h1 itemprop="title"><a href="index.html" itemprop="url"><xsl:value-of select="$ncx/ncx:ncx/ncx:docTitle/ncx:text/text()"/></a></h1>
            <p itemprop="byline"><xsl:value-of select="$ncx/ncx:ncx/ncx:docAuthor/ncx:text/text()"/></p>
          </div>
          <xsl:apply-templates select="opf:spine/opf:itemref"/>
        </article>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="opf:itemref">
    <xsl:variable name="src">
      <xsl:value-of select="string(key('id', @idref)/@href)"/>
    </xsl:variable>
    <div itemscope="itemscope">
      <h3 itemprop="title"><a href="{substring-before($src, '.xml')}.html" itemprop="url"><xsl:value-of select="$ncx//ncx:content[@src eq $src]/parent::ncx:navPoint/ncx:navLabel/ncx:text/text()"/></a></h3>
    </div>
  </xsl:template>
</xsl:stylesheet>
