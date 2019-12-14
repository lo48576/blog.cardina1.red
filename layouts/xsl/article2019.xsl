<?xml version="1.0"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:d="https://www.cardina1.red/_ns/doc2019"
	xmlns:ds="https://www.cardina1.red/_ns/doc2019/stylesheet"
	exclude-result-prefixes="xsl d ds"
>
<xsl:import href="doc2019/doc2019.xsl" />
<xsl:import href="part/article2019-code.xsl" />
<xsl:import href="part/article2019-permalink.xsl" />
<xsl:import href="part/article2019-img.xsl" />

<xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes" />

<xsl:template match="/"><xsl:apply-templates /></xsl:template>

<xsl:template match="*" mode="ds:footnotes-title">
	<xsl:text>脚注</xsl:text>
</xsl:template>

</xsl:stylesheet>
