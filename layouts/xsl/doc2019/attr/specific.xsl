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

<!-- Customization point for each (specific) elements. -->
<xsl:template match="*" mode="ds:attr-specific">
	<xsl:call-template name="ds:attr-specific" />
</xsl:template>

<xsl:template name="ds:attr-specific">
	<xsl:apply-templates select="." mode="ds:default-attr-specific" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-specific" />

</xsl:stylesheet>
