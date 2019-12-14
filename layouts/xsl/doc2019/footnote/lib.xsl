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

<!-- Returns footnote definition ID. -->
<xsl:template match="d:footnote" mode="ds:footnote-id">
	<xsl:value-of select="@xml:id" />
</xsl:template>

<xsl:template match="d:footnoteref" mode="ds:footnote-id">
	<xsl:value-of select="@linkend" />
</xsl:template>


<!-- Returns footnote refmark ID. -->
<xsl:template match="d:footnote" mode="ds:footnote-refmark-id">
	<xsl:value-of select="@refmark-id" />
</xsl:template>

<xsl:template match="d:footnoteref" mode="ds:footnote-refmark-id">
	<xsl:value-of select="@xml:id" />
</xsl:template>


<!-- Returns the footnote index. -->
<xsl:template match="d:footnote | d:footnoteref" mode="ds:footnote-index">
	<xsl:variable name="footnote-id">
		<xsl:apply-templates select="." mode="ds:footnote-id" />
	</xsl:variable>

	<xsl:value-of select="count(//d:footnote[@xml:id = $footnote-id]/preceding::d:footnote)" />
</xsl:template>


<!--
	Returns the footnote refmark index with the same target.
	The first refmark is 0.
-->
<xsl:template match="d:footnote | d:footnoteref" mode="ds:footnoteref-index">
	<xsl:variable name="footnote-id">
		<xsl:apply-templates select="." mode="ds:footnote-id" />
	</xsl:variable>
	<xsl:variable name="group-id">
		<xsl:apply-templates select="." mode="ds:footnote-group-id" />
	</xsl:variable>

	<xsl:value-of select="count(preceding::d:footnote[@xml:id = $footnote-id] | preceding::d:footnoteref[@linkend = $footnote-id])" />
</xsl:template>


<!-- Returns the number of footnote refmark index with the same target. -->
<xsl:template match="d:footnote | d:footnoteref" mode="ds:footnoteref-count">
	<xsl:variable name="footnote-id">
		<xsl:apply-templates select="." mode="ds:footnote-id" />
	</xsl:variable>

	<xsl:value-of select="count(//d:footnote[@xml:id = $footnote-id] | //d:footnoteref[@linkend = $footnote-id])" />
</xsl:template>

</xsl:stylesheet>
