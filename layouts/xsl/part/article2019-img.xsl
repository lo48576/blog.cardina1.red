<?xml version="1.0"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:d="https://www.cardina1.red/_ns/doc2019"
	xmlns:xl="http://www.w3.org/1999/xlink"
	xmlns:ds="https://www.cardina1.red/_ns/doc2019/stylesheet"
	exclude-result-prefixes="xsl d ds xl"
>
<xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes" />

<xsl:template name="img-base">
	<xsl:apply-imports select="." />
</xsl:template>

<!-- Wrap the image by blur container, if necessary. -->
<xsl:template name="img-blur">
	<xsl:choose>
		<xsl:when test="contains(concat(' ', normalize-space(@role), ' '), ' blur ')">
			<div class="blur-container">
				<xsl:call-template name="img-base" />
			</div>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="img-base" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<!-- Make the image a link. -->
<xsl:template name="img-xlink">
	<xsl:variable name="href">
		<xsl:apply-templates select="." mode="ds:get-link-target" />
	</xsl:variable>

	<xsl:choose>
		<xsl:when test="$href != ''">
			<a href="{$href}">
				<xsl:apply-templates select="@xl:*" mode="ds:attrs-anchor-xlink" />
				<xsl:call-template name="img-blur" />
			</a>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="img-blur" />
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="d:img">
	<xsl:call-template name="img-xlink" />
</xsl:template>

</xsl:stylesheet>
