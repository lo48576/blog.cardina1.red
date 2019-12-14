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

<!-- Footnote marker. -->
<xsl:template match="d:footnote | d:footnoteref">
	<!-- Footnote definition ID. -->
	<xsl:variable name="footnote-id">
		<xsl:apply-templates select="." mode="ds:footnote-id" />
	</xsl:variable>
	<xsl:if test="$footnote-id = ''">
		<xsl:message>
			<xsl:text>`footnote` and `footnoteref` should have footnote definition ID.</xsl:text>
		</xsl:message>
	</xsl:if>
	<!-- Footnote refmark ID. -->
	<xsl:variable name="refmark-id">
		<xsl:apply-templates select="." mode="ds:footnote-refmark-id" />
	</xsl:variable>

	<sup>
		<xsl:apply-templates select="." mode="ds:attr-common">
			<!-- Use `$footnote-id` rather than `@xml:id`. -->
			<xsl:with-param name="emit-id-attr" select="'no'" />
		</xsl:apply-templates>
		<!-- Emit refmark ID if available. -->
		<xsl:if test="$refmark-id != ''">
			<xsl:attribute name="id">
				<xsl:value-of select="$refmark-id" />
			</xsl:attribute>
		</xsl:if>
		<!-- Provide footnote content text as title. -->
		<xsl:attribute name="title">
			<xsl:value-of select="normalize-space(//d:footnote[@xml:id = $footnote-id])" />
		</xsl:attribute>

		<xsl:element name="a">
			<xsl:apply-templates select="." mode="ds:attr-common">
				<!-- Parent `sup` has an ID. -->
				<xsl:with-param name="emit-id-attr" select="'no'" />
			</xsl:apply-templates>
			<xsl:attribute name="href">
				<xsl:text>#</xsl:text>
				<xsl:value-of select="$footnote-id" />
			</xsl:attribute>

			<xsl:apply-templates select="." mode="ds:inner" />
		</xsl:element>
	</sup>
</xsl:template>

<xsl:template match="d:footnote" mode="ds:default-attr-class-value-specific">
	<xsl:text>footnote-refmark</xsl:text>
</xsl:template>

<xsl:template match="d:footnote | d:footnoteref" mode="ds:inner">
	<xsl:variable name="footnote-index">
		<xsl:apply-templates select="." mode="ds:footnote-index" />
	</xsl:variable>
	<xsl:variable name="footnoteref-count">
		<xsl:apply-templates select="." mode="ds:footnoteref-count" />
	</xsl:variable>

	<xsl:text>[</xsl:text>
	<!-- Refmark index. -->
	<xsl:value-of select="$footnote-index" />
	<!-- Sub-index if there are two or more refmarks for the same footnote definition. -->
	<xsl:if test="number($footnoteref-count) &gt; 1">
		<xsl:variable name="footnoteref-index">
			<xsl:apply-templates select="." mode="ds:footnoteref-index" />
		</xsl:variable>
		<xsl:value-of select="substring('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', number($footnoteref-index) + 1, 1)" />
	</xsl:if>
	<xsl:text>]</xsl:text>
</xsl:template>

</xsl:stylesheet>
