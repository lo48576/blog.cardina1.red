<?xml version="1.0"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:d="https://www.cardina1.red/_ns/doc2019"
	xmlns:ds="https://www.cardina1.red/_ns/doc2019/stylesheet"
	exclude-result-prefixes="xsl d ds"
>
<xsl:include href="class.xsl" />
<xsl:include href="specific.xsl" />

<xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes" />

<!-- Default entry point for common attributes emitter. -->
<xsl:template match="*" mode="ds:attr-common">
	<xsl:param name="emit-id-attr" select="'yes'" />
	<xsl:param name="additional-class" />

	<xsl:call-template name="ds:attr-common">
		<xsl:with-param name="emit-id-attr" select="$emit-id-attr" />
	</xsl:call-template>
	<xsl:apply-templates select="." mode="ds:attr-class">
		<xsl:with-param name="additional-class" select="$additional-class" />
	</xsl:apply-templates>
	<xsl:apply-templates select="." mode="ds:attr-custom" />
	<xsl:apply-templates select="." mode="ds:attr-specific" />
</xsl:template>

<xsl:template name="ds:attr-common">
	<xsl:param name="emit-id-attr" select="'yes'" />

	<xsl:if test="$emit-id-attr = 'yes'">
		<xsl:apply-templates select="." mode="ds:attr-xml-id" />
	</xsl:if>
	<xsl:apply-templates select="." mode="ds:attr-xml-lang" />
</xsl:template>


<!-- Entrypoint and default impl for `@xml:id`. -->
<xsl:template match="*" mode="ds:attr-xml-id">
	<xsl:call-template name="ds:attr-xml-id" />
</xsl:template>

<xsl:template name="ds:attr-xml-id">
	<xsl:apply-templates select="." mode="ds:default-attr-xml-id" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-xml-id" />

<xsl:template match="d:*" mode="ds:default-attr-xml-id">
	<xsl:if test="@xml:id">
		<xsl:attribute name="id">
			<xsl:value-of select="@xml:id" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>


<!-- Entrypoint and default impl for `@xml:lang`. -->
<xsl:template match="*" mode="ds:attr-xml-lang">
	<xsl:call-template name="ds:attr-xml-lang" />
</xsl:template>

<xsl:template name="ds:attr-xml-lang">
	<xsl:apply-templates select="." mode="ds:default-attr-xml-lang" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-xml-lang" />

<xsl:template match="d:*" mode="ds:default-attr-xml-lang">
	<xsl:if test="@xml:lang">
		<xsl:attribute name="lang">
			<xsl:value-of select="@xml:lang" />
		</xsl:attribute>
		<xsl:attribute name="xml:lang">
			<xsl:value-of select="@xml:lang" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>


<!-- Customization point for custom attributes. -->
<xsl:template match="*" mode="ds:attr-custom">
	<xsl:call-template name="ds:attr-custom" />
</xsl:template>

<xsl:template name="ds:attr-custom">
	<xsl:apply-templates select="." mode="ds:default-attr-custom" />
</xsl:template>

<xsl:template match="*" mode="ds:default-attr-custom" />

</xsl:stylesheet>
