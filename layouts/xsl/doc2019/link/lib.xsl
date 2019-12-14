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

<!-- Returns link target specified by the given element. -->
<xsl:template match="*" mode="ds:get-link-target">
	<xsl:call-template name="ds:get-link-target" />
</xsl:template>

<xsl:template name="ds:get-link-target">
	<xsl:apply-templates select="." mode="ds:default-get-link-target" />
</xsl:template>

<xsl:template match="*" mode="ds:default-get-link-target" />

<xsl:template match="d:*" mode="ds:default-get-link-target">
	<xsl:if test="count(@linkend | xl:href) &gt; 1">
		<xsl:message terminate="yes">
			<xsl:text>`@linkend` and `@xl:href` cannot coexist.</xsl:text>
		</xsl:message>
	</xsl:if>
	<xsl:choose>
		<xsl:when test="@linkend">
			<xsl:apply-templates select="@linkend" mode="ds:link-resolve-xref" />
		</xsl:when>
		<xsl:when test="@xl:href">
			<xsl:apply-templates select="@xl:href" mode="ds:link-resolve-uri" />
		</xsl:when>
	</xsl:choose>
</xsl:template>


<!-- Customization point to modify xref link URI. -->
<xsl:template match="* | @* | text()" mode="ds:link-resolve-xref">
	<xsl:param name="value" select="." />

	<xsl:call-template name="ds:link-resolve-xref">
		<xsl:with-param name="value" select="$value" />
	</xsl:call-template>
</xsl:template>

<xsl:template name="ds:link-resolve-xref">
	<xsl:param name="value" select="." />

	<xsl:call-template name="ds:default-link-resolve-xref">
		<xsl:with-param name="value" select="$value" />
	</xsl:call-template>
</xsl:template>

<!-- By default, `$xref` should be resolved to `#{$xref}`. -->
<xsl:template name="ds:default-link-resolve-xref">
	<xsl:param name="value" select="." />

	<xsl:text>#</xsl:text>
	<xsl:value-of select="$value" />
</xsl:template>


<!-- Customization point to modify link URI. -->
<xsl:template match="* | @* | text()" mode="ds:link-resolve-uri">
	<xsl:param name="value" select="." />

	<xsl:call-template name="ds:link-resolve-uri">
		<xsl:with-param name="value" select="$value" />
	</xsl:call-template>
</xsl:template>

<xsl:template name="ds:link-resolve-uri">
	<xsl:param name="value" select="." />

	<xsl:call-template name="ds:default-link-resolve-uri">
		<xsl:with-param name="value" select="$value" />
	</xsl:call-template>
</xsl:template>

<!-- By default, `$uri` should be resolved to `{$uri}` (the non-modified value). -->
<xsl:template name="ds:default-link-resolve-uri">
	<xsl:param name="value" select="." />

	<xsl:value-of select="$value" />
</xsl:template>


<!-- Processes `@xl:*` and convert them to HTML attributes. -->
<xsl:template match="* | @*" mode="ds:attrs-anchor-xlink" />

<xsl:template match="@xl:show[. = 'new']" mode="ds:attrs-anchor-xlink">
	<xsl:attribute name="target">
		<xsl:text>_blank</xsl:text>
	</xsl:attribute>
	<xsl:attribute name="rel">
		<xsl:text>noopener noreferrer</xsl:text>
	</xsl:attribute>
</xsl:template>

<xsl:template match="@xl:title" mode="ds:attrs-anchor-xlink">
	<xsl:attribute name="title">
		<xsl:value-of select="." />
	</xsl:attribute>
</xsl:template>


<!-- Returns link text for the given xref target. -->
<xsl:template match="*" mode="ds:xref-label" />

<xsl:template match="d:*" mode="ds:xref-label">
	<xsl:variable name="xreflabel">
		<xsl:value-of select="normalize-space(@xreflabel)" />
	</xsl:variable>

	<xsl:choose>
		<!-- If the target has `@xreflabel`, use it. -->
		<xsl:when test="$xreflabel != ''">
			<xsl:value-of select="$xreflabel" />
		</xsl:when>
		<!-- If the target has no `@xreflabel`, use title content. -->
		<xsl:otherwise>
			<xsl:apply-templates select="." mode="ds:title-inner" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
