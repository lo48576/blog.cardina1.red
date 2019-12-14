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

<!-- Block media container. -->
<!-- TODO: Add attributes to specify sizing. -->
<xsl:template match="d:mediaobject">
	<div>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</div>
</xsl:template>

<xsl:template match="d:mediaobject" mode="ds:default-attr-class-value-specific">
	<xsl:text>mediaobject</xsl:text>
</xsl:template>


<!-- Inline media container. -->
<!-- TODO: Add attributes to specify sizing. -->
<xsl:template match="d:inlinemediaobject">
	<span style="display: inline-block">
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</span>
</xsl:template>

<xsl:template match="d:inlinemediaobject" mode="ds:default-attr-class-value-specific">
	<xsl:text>inlinemediaobject</xsl:text>
</xsl:template>


<!-- Image element. -->
<xsl:template match="d:img">
	<xsl:element name="img" namespcae="{$ds:html-ns}">
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</xsl:element>
</xsl:template>

<xsl:template match="d:img" mode="ds:default-attr-specific">
	<!-- Emit `alt` attribute even if it is not specified. -->
	<xsl:attribute name="alt">
		<xsl:value-of select="@alt" />
	</xsl:attribute>
	<xsl:attribute name="src">
		<xsl:value-of select="@src" />
	</xsl:attribute>
	<xsl:attribute name="title">
		<xsl:value-of select="@title" />
	</xsl:attribute>
</xsl:template>

</xsl:stylesheet>
