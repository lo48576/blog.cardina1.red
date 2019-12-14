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

<!-- Paragraph. -->
<xsl:template match="d:p">
	<p>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</p>
</xsl:template>


<!-- Literal layout (pre-formatted block). -->
<xsl:template match="d:literallayout">
	<pre>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</pre>
</xsl:template>

<xsl:template match="d:literallayout" mode="ds:default-attr-class-value-specific">
	<xsl:text>literallayout</xsl:text>
	<xsl:variable name="class" select="normalize-space(@class)" />
	<xsl:choose>
		<xsl:when test="$class = 'monospaced'">
			<xsl:text> literallayout-class-monospaced</xsl:text>
		</xsl:when>
		<xsl:when test="$class = 'normal'">
			<xsl:text> literallayout-class-normal</xsl:text>
		</xsl:when>
	</xsl:choose>
</xsl:template>


<!-- Horizontal rule. -->
<xsl:template match="d:hr">
	<hr>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</hr>
</xsl:template>

</xsl:stylesheet>
