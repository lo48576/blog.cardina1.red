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

<!-- Emits attributes for language. -->
<xsl:template match="*" mode="ds:attr-specific-language">
	<xsl:if test="@language">
		<xsl:attribute name="data-lang">
			<xsl:value-of select="@language" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>


<!-- Emits class values for language. -->
<xsl:template match="*" mode="ds:attr-specific-language-class-value">
	<xsl:if test="@language">
		<xsl:text>language-</xsl:text>
		<xsl:value-of select="@language" />
	</xsl:if>
</xsl:template>


<!-- Inline code. -->
<xsl:template match="d:code">
	<code>
		<xsl:apply-templates select="." mode="ds:attr-common">
			<xsl:with-param name="additional-class">
				<xsl:apply-templates select="." mode="ds:attr-specific-language-class-value" />
			</xsl:with-param>
		</xsl:apply-templates>
		<xsl:apply-templates select="." mode="ds:attr-specific-language" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</code>
</xsl:template>


<!-- Code block. -->
<xsl:template match="d:programlisting">
	<pre>
		<xsl:apply-templates select="." mode="ds:attr-common">
		</xsl:apply-templates>
		<code>
			<xsl:apply-templates select="." mode="ds:attr-specific-language" />
			<xsl:variable name="language-class">
				<xsl:apply-templates select="." mode="ds:attr-specific-language-class-value" />
			</xsl:variable>
			<xsl:if test="normalize-space($language-class) != ''">
				<xsl:attribute name="class">
					<xsl:value-of select="normalize-space($language-class)" />
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="." mode="ds:inner" />
		</code>
	</pre>
</xsl:template>

<xsl:template match="d:programlisting" mode="ds:default-attr-class-value-specific">
	<xsl:text>programlisting</xsl:text>
</xsl:template>


<!-- Screen output block. -->
<xsl:template match="d:screen">
	<pre>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<samp>
			<xsl:apply-templates select="." mode="ds:attr-common">
				<xsl:with-param name="emit-id-attr" select="'no'" />
			</xsl:apply-templates>
			<xsl:apply-templates select="." mode="ds:inner" />
		</samp>
	</pre>
</xsl:template>

<xsl:template match="d:screen" mode="ds:default-attr-class-value-specific">
	<xsl:text>screen</xsl:text>
</xsl:template>


<!-- Prompt string. -->
<xsl:template match="d:prompt">
	<span>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</span>
</xsl:template>

<xsl:template match="d:prompt" mode="ds:default-attr-class-value-specific">
	<xsl:text>prompt</xsl:text>
</xsl:template>


<!-- User-input string. -->
<xsl:template match="d:userinput">
	<kbd>
		<xsl:apply-templates select="." mode="ds:attr-common" />
		<xsl:apply-templates select="." mode="ds:inner" />
	</kbd>
</xsl:template>

<xsl:template match="d:userinput" mode="ds:default-attr-class-value-specific">
	<xsl:text>userinput</xsl:text>
</xsl:template>

</xsl:stylesheet>
