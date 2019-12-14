<?xml version="1.0"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:d="https://www.cardina1.red/_ns/doc2019"
	xmlns:ds="https://www.cardina1.red/_ns/doc2019/stylesheet"
	exclude-result-prefixes="xsl d ds"
>
<xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes" />

<xsl:template match="d:title[parent::d:article | parent::d:section]" mode="ds:section-heading-inner">
	<xsl:variable name="sect-id">
		<xsl:apply-templates select="." mode="ds:section-id" />
	</xsl:variable>
	<xsl:call-template name="permalink-head">
		<xsl:with-param name="id" select="$sect-id" />
	</xsl:call-template>
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="d:title[parent::d:caution | parent::d:important | parent::d:note | parent::d:tip | parent::d:warning]" mode="ds:section-heading-inner">
	<xsl:variable name="sect-id">
		<xsl:apply-templates select="." mode="ds:section-id" />
	</xsl:variable>
	<xsl:apply-templates />
	<xsl:call-template name="permalink-tail">
		<xsl:with-param name="id" select="$sect-id" />
	</xsl:call-template>
</xsl:template>

<xsl:template name="permalink-head">
	<xsl:param name="node" select="." />
	<xsl:param name="id" select="$node/@xml:id" />
	<xsl:variable name="normalized-id" select="normalize-space($id)" />

	<!--
		Always put permalink, even if the section does not have `@id`.
		This makes section header structure consistent.
		It can be easily hidden using CSS when unneeded.
	-->
	<xsl:element name="a" namespace="{$ds:html-ns}">
		<xsl:attribute name="class">
			<xsl:text>permalink permalink-head</xsl:text>
		</xsl:attribute>
		<xsl:if test="$normalized-id != ''">
			<xsl:attribute name="href">
				<xsl:text>#</xsl:text>
				<xsl:value-of select="$normalized-id" />
			</xsl:attribute>
		</xsl:if>
		<xsl:comment><xsl:text> </xsl:text></xsl:comment>
	</xsl:element>
</xsl:template>

<xsl:template name="permalink-tail">
	<xsl:param name="node" select="." />
	<xsl:param name="id" select="$node/@xml:id" />
	<xsl:variable name="normalized-id" select="normalize-space($id)" />

	<!-- Permalink at the tail is omissible. -->
	<xsl:if test="$normalized-id != ''">
		<xsl:element name="a" namespace="{$ds:html-ns}">
			<xsl:attribute name="class">
				<xsl:text>permalink permalink-tail</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="href">
				<xsl:text>#</xsl:text>
				<xsl:value-of select="$normalized-id" />
			</xsl:attribute>
			<xsl:comment><xsl:text> </xsl:text></xsl:comment>
		</xsl:element>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
