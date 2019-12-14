<?xml version="1.0"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:d="https://www.cardina1.red/_ns/doc2019"
	xmlns:ds="https://www.cardina1.red/_ns/doc2019/stylesheet"
	xmlns:xl="http://www.w3.org/1999/xlink"
	exclude-result-prefixes="xsl d ds xl"
>
<xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes" />


<!-- Template for `link` element. -->
<xsl:template match="d:link">
	<xsl:variable name="href">
		<xsl:apply-templates select="." mode="ds:get-link-target" />
	</xsl:variable>

	<a>
		<xsl:if test="$href != ''">
			<xsl:attribute name="href">
				<xsl:value-of select="$href" />
			</xsl:attribute>
		</xsl:if>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="@xl:*" mode="ds:attrs-anchor-xlink" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</a>
</xsl:template>


<!-- Template for `xref` element. -->
<xsl:template match="d:xref">
	<!-- Ensure the element has `@linkend` attribute. -->
	<xsl:if test="not(@linkend)">
		<xsl:message terminate="yes">
			<xsl:text>`xref` element should have `linkend` attribute.</xsl:text>
		</xsl:message>
	</xsl:if>
	<a>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:attribute name="href">
			<xsl:apply-templates select="@linkend" mode="ds:link-resolve-xref" />
		</xsl:attribute>
		<xsl:apply-templates select="@xl:*" mode="ds:attrs-anchor-xlink" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</a>
</xsl:template>

<xsl:template match="d:xref" mode="ds:inner">
	<xsl:variable name="linkend" select="@linkend" />

	<xsl:apply-templates select="//*[@xml:id = $linkend]" mode="ds:xref-label" />
</xsl:template>

</xsl:stylesheet>
