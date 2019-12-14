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

<!-- Table. -->
<xsl:template match="d:table">
	<table>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</table>
</xsl:template>


<!-- Table caption. -->
<xsl:template match="d:table/d:caption">
	<caption>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</caption>
</xsl:template>


<!-- Table column group. -->
<xsl:template match="d:colgroup">
	<colgroup>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</colgroup>
</xsl:template>

<xsl:template match="d:colgroup" mode="ds:default-attr-specific">
	<xsl:if test="@span">
		<xsl:attribute name="span">
			<xsl:value-of select="@span" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>


<!-- Table column. -->
<xsl:template match="d:col">
	<col>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</col>
</xsl:template>

<xsl:template match="d:col" mode="ds:default-attr-specific">
	<xsl:if test="@span">
		<xsl:attribute name="span">
			<xsl:value-of select="@span" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>


<!-- Table header, body, footer. -->
<xsl:template match="d:thead | d:tbody | d:tfoot">
	<xsl:element name="{local-name()}">
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</xsl:element>
</xsl:template>


<!-- Table row. -->
<xsl:template match="d:tr">
	<tr>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</tr>
</xsl:template>

<!-- Table cells. -->
<xsl:template match="d:td | d:th">
	<xsl:element name="{local-name()}">
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</xsl:element>
</xsl:template>

<xsl:template match="d:td | d:th" mode="ds:default-attr-specific">
	<xsl:if test="self::d:th and @abbr">
		<xsl:attribute name="abbr">
			<xsl:value-of select="@abbr" />
		</xsl:attribute>
	</xsl:if>
	<xsl:if test="@colspan">
		<xsl:attribute name="colspan">
			<xsl:value-of select="@colspan" />
		</xsl:attribute>
	</xsl:if>
	<xsl:if test="@headers">
		<xsl:attribute name="headers">
			<xsl:value-of select="@headers" />
		</xsl:attribute>
	</xsl:if>
	<xsl:if test="@rowspan">
		<xsl:attribute name="rowspan">
			<xsl:value-of select="@rowspan" />
		</xsl:attribute>
	</xsl:if>
	<xsl:if test="self::d:th and @scope">
		<xsl:attribute name="scope">
			<xsl:value-of select="@scope" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
