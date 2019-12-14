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

<!-- `strong`. -->
<xsl:template match="d:strong">
	<strong>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</strong>
</xsl:template>


<!-- Line break. -->
<xsl:template match="d:br">
	<xsl:element name="br" namespace="{$ds:html-ns}">
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</xsl:element>
</xsl:template>


<!-- Ruby. -->
<xsl:template match="d:ruby | d:rp | d:rt">
	<xsl:element name="{local-name()}">
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</xsl:element>
</xsl:template>


<!-- Insertion and deletion. -->
<xsl:template match="d:ins | d:del">
	<xsl:element name="{local-name()}">
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</xsl:element>
</xsl:template>

<xsl:template match="d:ins | d:del" mode="ds:default-attr-specific">
	<xsl:if test="@cite">
		<xsl:attribute name="cite">
			<xsl:value-of select="@cite" />
		</xsl:attribute>
	</xsl:if>
	<xsl:if test="@datetime">
		<xsl:attribute name="datetime">
			<xsl:value-of select="@datetime" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>


<!-- Superscript and subscript. -->
<xsl:template match="d:sup | d:sub">
	<xsl:element name="{local-name()}">
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</xsl:element>
</xsl:template>


<!-- Filename and path. -->
<xsl:template match="d:filename">
	<span>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</span>
</xsl:template>

<xsl:template match="d:filename" mode="ds:default-attr-class-value-specific">
	<xsl:text>filename</xsl:text>
	<xsl:choose>
		<xsl:when test="@class = 'directory'">
			<xsl:text> filename-class-directory</xsl:text>
		</xsl:when>
	</xsl:choose>
</xsl:template>


<!-- URI. -->
<xsl:template match="d:uri">
	<span>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</span>
</xsl:template>

<xsl:template match="d:uri" mode="ds:default-attr-class-value-specific">
	<xsl:text>uri</xsl:text>
</xsl:template>


<!-- Date and time. -->
<xsl:template match="d:time">
	<time>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</time>
</xsl:template>

<xsl:template match="d:time" mode="ds:default-attr-specific">
	<xsl:if test="@datetime">
		<xsl:attribute name="datetime">
			<xsl:value-of select="@datetime" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>


<!-- Key input combination. -->
<xsl:template match="d:keycombo">
	<kbd>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</kbd>
</xsl:template>

<xsl:template match="d:keycombo" mode="ds:default-attr-class-value-specific">
	<xsl:text>keycombo</xsl:text>
	<xsl:choose>
		<xsl:when test="@action = 'simul'">
			<xsl:text> keycombo-action-simul</xsl:text>
		</xsl:when>
	</xsl:choose>
</xsl:template>


<!-- Key input. -->
<xsl:template match="d:keycap">
	<kbd>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</kbd>
</xsl:template>

<xsl:template match="d:keycap" mode="ds:default-attr-class-value-specific">
	<xsl:text>keycap</xsl:text>
	<xsl:choose>
		<xsl:when test="@function = 'shift'">
			<xsl:text> keycap-function-shit</xsl:text>
		</xsl:when>
	</xsl:choose>
</xsl:template>


<!-- Phrase, without specific meaning defined by this schema. -->
<xsl:template match="d:phrase">
	<span>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</span>
</xsl:template>

</xsl:stylesheet>
