<?xml version="1.0"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:d="https://www.cardina1.red/_ns/doc2019"
	xmlns:ds="https://www.cardina1.red/_ns/doc2019/stylesheet"
	exclude-result-prefixes="xsl d ds"
>
<xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes" />

<xsl:template match="*" mode="ds:attr-specific-language-class-value">
	<xsl:if test="@language">
		<xsl:text>code-highlight language-</xsl:text>
		<xsl:value-of select="@language" />
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
