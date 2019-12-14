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

<!-- Footnotes section. -->
<xsl:template match="*" mode="ds:footnotes">
	<aside>
		<xsl:apply-templates select="." mode="ds:footnotes-attrs" />
		<xsl:variable name="section-level">
			<xsl:apply-templates select="." mode="ds:html-header-level">
				<!-- offset 1 for `aside`. -->
				<xsl:with-param name="level-offset" select="1" />
			</xsl:apply-templates>
		</xsl:variable>
		<xsl:element name="h{$section-level}">
			<xsl:apply-templates select="." mode="ds:footnotes-title" />
		</xsl:element>

		<xsl:apply-templates select="." mode="ds:footnotes-inner" />
	</aside>
</xsl:template>

<xsl:template match="*" mode="ds:footnotes-attrs">
	<xsl:attribute name="class">
		<xsl:text>footnotes</xsl:text>
	</xsl:attribute>
</xsl:template>


<!-- Content of footnotes section. -->
<xsl:template match="*" mode="ds:footnotes-inner">
	<ol start="0">
		<xsl:apply-templates select="." mode="ds:attr-common">
			<xsl:with-param name="emit-id-attr" select="'no'" />
			<xsl:with-param name="additional-class">
				<xsl:value-of select="$ds:attr-class-prefix" />
				<xsl:text>footnote-list</xsl:text>
			</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select=".//d:footnote" mode="ds:footnotes-item" />
	</ol>
</xsl:template>


<!-- Footnotes section title. -->
<xsl:template match="*" mode="ds:footnotes-title">
	<xsl:text>Footnotes</xsl:text>
</xsl:template>


<!-- Footnote item. -->
<xsl:template match="d:footnote" mode="ds:footnotes-item">
	<li>
		<xsl:apply-templates select="." mode="ds:attr-common">
			<xsl:with-param name="additional-class">
				<xsl:text>footnote-item</xsl:text>
			</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="ds:footnotes-item-inner" />
	</li>
</xsl:template>

<!-- Content of footnote item node. -->
<xsl:template match="d:footnote" mode="ds:footnotes-item-inner">
	<xsl:apply-templates />
	<xsl:apply-templates select="." mode="ds:footnote-revrefs" />
</xsl:template>


<!-- Reverse link to footnote refmarks. -->
<xsl:template match="d:footnote" mode="ds:footnote-revrefs">
	<xsl:variable name="footnote-id" select="@xml:id" />

	<xsl:for-each select="//d:footnote[@xml:id = $footnote-id] | //d:footnoteref[@linkend = $footnote-id]">
		<xsl:variable name="refmark-id">
			<xsl:apply-templates select="." mode="ds:footnote-refmark-id" />
		</xsl:variable>
		<a>
			<xsl:apply-templates select="." mode="ds:attr-common">
				<xsl:with-param name="emit-id-attr" select="'no'" />
			</xsl:apply-templates>
			<xsl:attribute name="href">
				<xsl:text>#</xsl:text>
				<xsl:value-of select="$refmark-id" />
			</xsl:attribute>
			<xsl:attribute name="title">
				<xsl:value-of select="$refmark-id" />
			</xsl:attribute>

			<xsl:apply-templates select="." mode="ds:footnote-revlabel" />
		</a>
	</xsl:for-each>
</xsl:template>


<!-- Returns label of reverse link to the footnote refmark. -->
<xsl:template match="d:footnote | d:footnoteref" mode="ds:footnote-revlabel">
	<xsl:variable name="footnote-index">
		<xsl:apply-templates select="." mode="ds:footnote-index" />
	</xsl:variable>
	<xsl:variable name="footnoteref-count">
		<xsl:apply-templates select="." mode="ds:footnoteref-count" />
	</xsl:variable>

	<xsl:text>[</xsl:text>
	<xsl:value-of select="$footnote-index" />
	<xsl:if test="number($footnoteref-count) &gt; 1">
		<xsl:variable name="footnoteref-index">
			<xsl:apply-templates select="." mode="ds:footnoteref-index" />
		</xsl:variable>
		<xsl:value-of select="substring('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', number($footnoteref-index) + 1, 1)" />
	</xsl:if>
	<xsl:text>]</xsl:text>
</xsl:template>

</xsl:stylesheet>
