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

<!-- Inline quote. -->
<xsl:template match="d:quote">
	<q>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:if test="@cite">
			<xsl:attribute name="cite">
				<xsl:value-of select="@cite" />
			</xsl:attribute>
		</xsl:if>

		<xsl:apply-templates select="." mode="ds:inner" />
	</q>
</xsl:template>

<xsl:template match="d:quote[d:qp]">
	<span>
		<xsl:apply-templates select="." mode="ds:attr-common" />

		<xsl:apply-templates select="." mode="ds:quote-paren-front" />
		<q>
			<xsl:apply-templates select="." mode="ds:attr-common">
				<xsl:with-param name="emit-id-attr" select="'no'" />
			</xsl:apply-templates>
			<xsl:if test="@cite">
				<xsl:attribute name="cite">
					<xsl:value-of select="@cite" />
				</xsl:attribute>
			</xsl:if>

			<xsl:apply-templates select="." mode="ds:inner" />
		</q>
		<xsl:apply-templates select="." mode="ds:quote-paren-tail" />
	</span>
</xsl:template>

<xsl:template match="d:quote" mode="ds:quote-paren-front">
	<xsl:apply-templates select="d:*[1][self::d:qp]" />
</xsl:template>

<xsl:template match="d:quote" mode="ds:quote-paren-tail">
	<xsl:apply-templates select="d:*[last()][self::d:qp]" />
</xsl:template>

<xsl:template match="d:quote[d:qp]" mode="ds:inner">
	<xsl:apply-templates select="*[not(self::d:qp)] | text() | comment()" />
</xsl:template>

<xsl:template match="d:quote" mode="ds:default-attr-class-value-specific">
	<xsl:if test="d:qp">
		<!-- Set `quotes: none;` for elements for `q.no-css-quotes`. -->
		<xsl:text>no-css-quotes</xsl:text>
	</xsl:if>
</xsl:template>


<!-- Quote paren. -->
<xsl:template match="d:qp">
	<span>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</span>
</xsl:template>


<!-- Quoter's comment inside quoted content. -->
<xsl:template match="d:quotecomment">
	<span>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</span>
</xsl:template>

</xsl:stylesheet>
