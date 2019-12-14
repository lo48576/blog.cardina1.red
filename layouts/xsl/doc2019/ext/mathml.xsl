<?xml version="1.0"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:mml="http://www.w3.org/1998/Math/MathML"
	exclude-result-prefixes="xsl mml"
>
<xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes" />

<!-- TODO: Forbid content markup or convert them into presentation markup. -->
<xsl:template match="mml:*">
	<xsl:if test="substring(local-name(), 1, 1) != 'm'">
		<xsl:message>
			<xsl:text>HTML only supports presentation markup of MathML, but got `</xsl:text>
			<xsl:value-of select="local-name()" />
			<xsl:text>`.</xsl:text>
		</xsl:message>
	</xsl:if>

	<xsl:element name="{local-name()}" namespace="{namespace-uri()}">
		<xsl:copy-of select="@*" />
		<xsl:apply-templates />
	</xsl:element>
</xsl:template>

</xsl:stylesheet>
