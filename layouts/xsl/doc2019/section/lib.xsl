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

<!-- Returns HTML header level for the given section. -->
<xsl:template match="*" mode="ds:html-header-level">
	<xsl:param name="level-offset" select="0" />
	<xsl:param name="section-level">
		<xsl:apply-templates select="." mode="ds:section-level" />
	</xsl:param>
	<!-- 1-based section level. -->
	<xsl:variable name="section-level-one-based" select="number($section-level) + 1 + number($level-offset)" />

	<xsl:choose>
		<xsl:when test="$section-level-one-based &lt;= 6">
			<xsl:value-of select="$section-level-one-based" />
		</xsl:when>
		<xsl:otherwise>6</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="ds:html-header-level">
	<xsl:param name="node" select="." />
	<xsl:param name="level-offset" select="0" />
	<xsl:param name="section-level">
		<xsl:apply-templates select="$node" mode="ds:section-level" />
	</xsl:param>

	<xsl:apply-templates select="$node" mode="ds:html-header-level">
		<xsl:with-param name="level-offset" select="$level-offset" />
		<xsl:with-param name="section-level" select="$section-level" />
	</xsl:apply-templates>
</xsl:template>


<!-- Returns section level of the given section. -->
<!-- Outermost section is level-0. -->
<xsl:template match="*" mode="ds:section-level">
	<xsl:value-of select="count(
			ancestor::d:article |
			ancestor::d:section |
			ancestor::d:caution |
			ancestor::d:important |
			ancestor::d:note |
			ancestor::d:tip |
			ancestor::d:warning
			)" />
</xsl:template>

<xsl:template name="ds:section-level">
	<xsl:param name="node" select="." />

	<xsl:apply-templates select="$node" mode="ds:section-level" />
</xsl:template>


<!-- Returns the section ID of the innermost section the given element belongs. -->
<xsl:template match="*" mode="ds:section-id">
	<xsl:value-of select="(
			ancestor-or-self::d:article |
			ancestor-or-self::d:section |
			ancestor-or-self::d:caution |
			ancestor-or-self::d:important |
			ancestor-or-self::d:note |
			ancestor-or-self::d:tip |
			ancestor-or-self::d:warning
		)[last()]/@xml:id" />
</xsl:template>

</xsl:stylesheet>
