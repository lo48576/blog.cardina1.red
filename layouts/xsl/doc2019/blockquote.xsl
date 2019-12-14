<?xml version="1.0"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:d="https://www.cardina1.red/_ns/doc2019"
	xmlns:ds="https://www.cardina1.red/_ns/doc2019/stylesheet"
	exclude-result-prefixes="xsl d ds"
>
<xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes" />

<!-- Blockquote with footer. -->
<xsl:template match="d:blockquote[d:*[last()]/self::d:footer]">
	<!-- Footer exists. -->
	<figure>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</figure>
</xsl:template>

<!-- Blockquote without footer. -->
<xsl:template match="d:blockquote[not(d:*[last()]/self::d:footer)]">
	<!-- Footer does not exist. -->
	<blockquote>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</blockquote>
</xsl:template>

<xsl:template match="d:blockquote[d:*[last()]/self::d:footer]" mode="ds:inner">
	<blockquote>
		<xsl:apply-templates select="." mode="ds:attr-common">
			<xsl:with-param name="emit-id-attr" select="'no'" />
		</xsl:apply-templates>
		<xsl:apply-templates select="*[not(self::d:*[last()]/self::d:footer)] | text()" />
	</blockquote>
	<xsl:apply-templates select="d:*[last()]/self::d:footer" />
</xsl:template>

<!-- Blockquote footer. -->
<xsl:template match="d:blockquote/d:footer">
	<figcaption>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</figcaption>
</xsl:template>


<!-- Blockquote attribution. -->
<xsl:template match="d:blockquote/d:footer//d:attribution">
	<span>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</span>
</xsl:template>


<!-- Blockquote citetitle. -->
<xsl:template match="d:blockquote/d:footer//d:citetitle">
	<cite>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</cite>
</xsl:template>


<!-- Blockquote comment. -->
<xsl:template match="d:blockquote/d:footer//d:comment">
	<span>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</span>
</xsl:template>


<!-- Referred date of quoted document. -->
<xsl:template match="d:blockquote/d:footer//d:reftime">
	<time>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</time>
</xsl:template>


<!-- Publish date of quoted document. -->
<xsl:template match="d:blockquote/d:footer//d:pubdate">
	<span>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</span>
</xsl:template>

</xsl:stylesheet>
