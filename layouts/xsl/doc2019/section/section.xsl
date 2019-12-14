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

<!-- Ignore `d:title` by default. -->
<xsl:template match="d:title" />

<!-- Ignore all elements in section heading by default. -->
<xsl:template match="*" mode="ds:section-heading" />


<!-- Returns title content. Mainly used by templates for cross references. -->
<xsl:template match="*" mode="ds:title-inner" />

<xsl:template match="d:*" mode="ds:title-inner">
	<xsl:choose>
		<xsl:when test="d:title">
			<xsl:apply-templates select="d:title" mode="ds:inner" />
		</xsl:when>
		<xsl:when test="d:info/d:title">
			<xsl:apply-templates select="d:info/d:title" mode="ds:inner" />
		</xsl:when>
	</xsl:choose>
</xsl:template>


<!-- Section heading. -->
<xsl:template match="*" mode="ds:section-heading" />

<xsl:template match="d:*" mode="ds:section-heading">
	<xsl:apply-templates select="d:title" mode="ds:section-heading" />
</xsl:template>

<xsl:template match="d:title" mode="ds:section-heading">
	<xsl:variable name="html-header-level">
		<xsl:apply-templates select="." mode="ds:html-header-level">
			<xsl:with-param name="level-offset" select="-1" />
		</xsl:apply-templates>
	</xsl:variable>

	<xsl:element name="h{$html-header-level}" namespace="{$ds:html-ns}">
		<xsl:apply-templates select="." mode="ds:attr-common">
			<xsl:with-param name="emit-id-attr" select="'no'" />
		</xsl:apply-templates>

		<xsl:apply-templates select="." mode="ds:section-heading-inner" />
	</xsl:element>
</xsl:template>

<xsl:template match="d:title" mode="ds:section-heading-inner">
	<xsl:apply-templates />
</xsl:template>


<!-- Section footer. -->
<xsl:template match="d:*" mode="ds:section-footer" />

<xsl:template match="d:article" mode="ds:section-footer">
	<xsl:if test=".//d:footnote">
		<div>
			<xsl:apply-templates select="." mode="ds:section-footer-inner" />
		</div>
	</xsl:if>
</xsl:template>

<xsl:template match="d:article" mode="ds:section-footer-inner">
	<xsl:if test=".//d:footnote">
		<xsl:apply-templates select="." mode="ds:footnotes" />
	</xsl:if>
</xsl:template>


<!-- Article. -->
<xsl:template match="d:article">
	<article>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</article>
</xsl:template>

<xsl:template match="d:article" mode="ds:inner">
	<xsl:apply-templates select="." mode="ds:section-heading" />
	<!-- Process preamble. -->
	<xsl:apply-templates select="d:section[1]/preceding-sibling::d:*" />
	<!-- Table of contents. -->
	<xsl:apply-templates select="." mode="ds:toc" />
	<!-- Sections. -->
	<xsl:apply-templates select="d:section[1] | d:section[1]/following-sibling::d:*" />
	<xsl:apply-templates select="." mode="ds:section-footer" />
</xsl:template>


<!-- Section. -->
<xsl:template match="d:section">
	<section>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</section>
</xsl:template>

<xsl:template match="d:section" mode="ds:inner">
	<xsl:apply-templates select="." mode="ds:section-heading" />
	<xsl:apply-templates />
	<xsl:apply-templates select="." mode="ds:section-footer" />
</xsl:template>


<!-- Admonitions. -->
<xsl:template match="d:caution | d:important | d:note | d:tip | d:warning">
	<aside>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</aside>
</xsl:template>

<xsl:template match="d:caution | d:important | d:note | d:tip | d:warning" mode="ds:inner">
	<xsl:apply-templates select="." mode="ds:section-heading" />
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="d:caution | d:important | d:note | d:tip | d:warning" mode="ds:default-attr-class-value-specific">
	<xsl:text>admonition </xsl:text>
	<xsl:value-of select="local-name()" />
</xsl:template>

</xsl:stylesheet>
