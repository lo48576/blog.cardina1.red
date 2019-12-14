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

<!-- Emits `@class` created from the given parameters. -->
<xsl:template match="*" mode="ds:attr-class">
	<xsl:param name="additional-class" />
	<xsl:variable name="attr-value-raw">
		<xsl:apply-templates select="." mode="ds:attr-class-value" />
		<xsl:text> </xsl:text>
		<xsl:value-of select="$additional-class" />
	</xsl:variable>
	<xsl:variable name="attr-value" select="normalize-space($attr-value-raw)" />
	<xsl:if test="$attr-value != ''">
		<xsl:attribute name="class">
			<xsl:value-of select="$attr-value" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>


<!-- Returns the value for `@class` of the context node. -->
<xsl:template match="*" mode="ds:attr-class-value">
	<xsl:call-template name="ds:attr-class-value" />
</xsl:template>

<xsl:template name="ds:attr-class-value">
	<xsl:text> </xsl:text>
	<xsl:apply-templates select="." mode="ds:default-attr-class-value" />
	<xsl:text> </xsl:text>
	<xsl:apply-templates select="." mode="ds:default-attr-class-value-specific" />
	<xsl:text> </xsl:text>
</xsl:template>

<!-- Use `@role` as default `class` value. -->
<xsl:template match="*" mode="ds:default-attr-class-value">
	<xsl:if test="@role">
		<xsl:value-of select="@role" />
	</xsl:if>
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-class-value-specific" />

</xsl:stylesheet>
