<?xml version="1.0"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:html="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="xsl html"
>
<xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes" />

<xsl:template match="html:*">
	<xsl:element name="{local-name(.)}">
		<xsl:copy-of select="@*" />
		<xsl:apply-templates />
		<!-- About void elements, see <https://developer.mozilla.org/en-US/docs/Glossary/Empty_element>. -->
		<xsl:choose>
			<!-- Void elements should be self-closing tag. -->
			<xsl:when test="
				self::html:area |
				self::html:base |
				self::html:br |
				self::html:col |
				self::html:emded |
				self::html:hr |
				self::html:img |
				self::html:input |
				self::html:link |
				self::html:meta |
				self::html:param |
				self::html:source |
				self::html:track |
				self::html:wbr
				" />
			<!-- Non-void elements with child content cannot not be self-closing and no more things to do. -->
			<xsl:when test="node() | text() | comment()" />
			<!-- Non-void elements without child content should not be self-closing. -->
			<xsl:otherwise>
				<xsl:comment><xsl:text> </xsl:text></xsl:comment>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:element>
</xsl:template>

<xsl:template match="*"><xsl:apply-templates /></xsl:template>

<xsl:template match="text() | comment()"><xsl:copy-of select="." /></xsl:template>

</xsl:stylesheet>
