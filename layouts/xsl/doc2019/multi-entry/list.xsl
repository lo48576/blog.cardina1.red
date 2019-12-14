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

<!-- Ordered list. -->
<xsl:template match="d:ol">
	<ol>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</ol>
</xsl:template>

<xsl:template match="d:ol" mode="ds:default-attr-class-value-specific">
	<xsl:variable name="spacing" select="normalize-space(@spacing)" />
	<xsl:choose>
		<xsl:when test="$spacing = 'compact'">
			<xsl:text>ul-spacing-compact</xsl:text>
		</xsl:when>
		<xsl:when test="$spacing = 'normal'">
			<xsl:text>ul-spacing-normal</xsl:text>
		</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template match="d:ol" mode="ds:default-attr-specific">
	<xsl:if test="@start">
		<xsl:attribute name="start">
			<xsl:value-of select="@start" />
		</xsl:attribute>
	</xsl:if>
	<xsl:if test="@type">
		<xsl:attribute name="type">
			<xsl:value-of select="@type" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>


<!-- Unordered list. -->
<xsl:template match="d:ul">
	<ul>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</ul>
</xsl:template>

<xsl:template match="d:ul" mode="ds:default-attr-class-value-specific">
	<xsl:variable name="spacing" select="normalize-space(@spacing)" />
	<xsl:choose>
		<xsl:when test="$spacing = 'compact'">
			<xsl:text>ol-spacing-compact</xsl:text>
		</xsl:when>
		<xsl:when test="$spacing = 'normal'">
			<xsl:text>ol-spacing-normal</xsl:text>
		</xsl:when>
	</xsl:choose>
</xsl:template>


<!-- List item. -->
<xsl:template match="d:ol/d:li | d:ul/d:li">
	<li>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</li>
</xsl:template>

</xsl:stylesheet>
