<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" encoding="UTF-8" />
<xsl:variable name="vLower" select="'abcdefghijklmnopqrstuvwxyz'"/>
<xsl:variable name="vUpper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
<xsl:template match="table">package com.crud;

import java.io.Serializable;
import java.math.*;
import java.util.*;
import javax.persistence.*;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.springframework.data.domain.Persistable;
import lombok.*;
<xsl:if test='count(columns/column[@primarykey])>1'>
@IdClass(<xsl:value-of select='translate(@class, $vLower, $vUpper)'/>VO.PK.class)</xsl:if>
@Getter
@Setter
@ToString
@Entity
@DynamicInsert
@DynamicUpdate
@Table(name = "<xsl:value-of select='@name'/>")
public class <xsl:value-of select='translate(@class, $vLower, $vUpper)'/>VO implements Persistable&lt;<xsl:if test='count(columns/column[@primarykey])=1'><xsl:value-of select='columns/column[@primarykey]/@type'/></xsl:if>
<xsl:if test='count(columns/column[@primarykey])>1'><xsl:value-of select='translate(@class, $vLower, $vUpper)'/>VO.PK</xsl:if>&gt; {
<xsl:for-each select="columns/column[@primarykey]">
	<xsl:if test="@auto_increment">
	@GeneratedValue(strategy = GenerationType.IDENTITY)</xsl:if>
	@Id
	@Column(name = "<xsl:value-of select='@name'/>")
	private <xsl:value-of select='@type'/><xsl:text> </xsl:text><xsl:call-template name="CamelCase"><xsl:with-param name="text" select="@name" /></xsl:call-template>;
</xsl:for-each>
<xsl:for-each select="columns/column[not(@primarykey)]">
	@Column(name = "<xsl:value-of select='@name'/>"<xsl:if test="@insert='none'">, insertable = false</xsl:if><xsl:if test="@update='none'">, updatable = false</xsl:if>)
	private <xsl:value-of select='@type'/><xsl:text> </xsl:text><xsl:call-template name="CamelCase"><xsl:with-param name="text" select="@name" /></xsl:call-template>;
</xsl:for-each>

<xsl:if test='count(columns/column[@primarykey])>1'>
	@NoArgsConstructor
	@AllArgsConstructor
	@EqualsAndHashCode
	@ToString
	public static class PK implements Serializable {<xsl:for-each select="columns/column[@primarykey]">
		private <xsl:value-of select='@type'/><xsl:text> </xsl:text><xsl:call-template name="CamelCase"><xsl:with-param name="text" select="@name" /></xsl:call-template>;</xsl:for-each>	
	}</xsl:if>
	
	//=================================
	// Persistable Method
	//=================================
	@Transient
	private boolean isNew = true;

	@PrePersist
	@PostLoad
	void markNotNew() {
		this.isNew = false;
	}

	@Override
	public boolean isNew() {
		return isNew;
	}
<xsl:if test='count(columns/column[@primarykey])=1'>
	@Override
	public <xsl:value-of select='columns/column[@primarykey]/@type'/> getId() {
		return <xsl:call-template name="CamelCase"><xsl:with-param name="text" select="columns/column[@primarykey]/@name" /></xsl:call-template>;
	}</xsl:if>
<xsl:if test='count(columns/column[@primarykey])>1'>
	@Override
	public PK getId() {
		return new PK(<xsl:for-each select="columns/column[@primarykey]"><xsl:if test='position()!=1'>, </xsl:if><xsl:call-template name="CamelCase"><xsl:with-param name="text" select="@name" /></xsl:call-template></xsl:for-each>);
	}</xsl:if>
}</xsl:template>
<xsl:template name="CamelCase">
	<xsl:param name="text" />
	<xsl:param name="lastletter" select="' '"/>
	<xsl:if test="$text">
		<xsl:variable name="thisletter" select="substring($text,1,1)"/>
		<xsl:choose>
			<xsl:when test="$lastletter='_'">
				<xsl:value-of select="translate($thisletter, $vLower, $vUpper)"/>
			</xsl:when>
			<xsl:when test="$thisletter='_'">
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$thisletter"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:call-template name="CamelCase">
			<xsl:with-param name="text" select="substring($text,2)"/>
			<xsl:with-param name="lastletter" select="$thisletter"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>
</xsl:stylesheet>