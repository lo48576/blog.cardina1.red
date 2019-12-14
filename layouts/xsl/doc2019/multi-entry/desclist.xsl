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

<!-- Description list. -->
<xsl:template match="d:dl">
	<dl>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</dl>
</xsl:template>

<xsl:template match="d:dl" mode="ds:default-attr-class-value-specific">
	<xsl:variable name="spacing" select="normalize-space(@spacing)" />
	<xsl:choose>
		<xsl:when test="$spacing = 'monospaced'">
			<xsl:text>dl-spacing-compact</xsl:text>
		</xsl:when>
		<xsl:when test="$spacing = 'normal'">
			<xsl:text>dl-spacing-normal</xsl:text>
		</xsl:when>
	</xsl:choose>
</xsl:template>


<!-- Description list entry. -->
<xsl:template match="d:dlentry">
	<div>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</div>
</xsl:template>


<!-- Description term. -->
<xsl:template match="d:dt">
	<dt>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</dt>
</xsl:template>


<!-- Description details. -->
<xsl:template match="d:dd">
	<dd>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</dd>
</xsl:template>

</xsl:stylesheet>
