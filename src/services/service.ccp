<Page id="1" templateExtension="html" relativePath=".." fullRelativePath=".\services" secured="False" urlType="Relative" isIncluded="False" SSLAccess="False" isService="True" cachingEnabled="False" cachingDuration="1 minutes" needGeneration="0">
	<Components>
		<Grid id="2" secured="False" sourceType="Table" returnValueType="Number" defaultPageSize="10" connection="Connection1" dataSource="propiedades" name="propiedades1" pageSizeLimit="100" wizardCaption=" Propiedades Lista de" wizardAllowInsert="False">
			<Components>
				<Label id="22" fieldSourceType="DBColumn" dataType="Text" html="False" name="descripcion" fieldSource="descripcion">
					<Components/>
					<Events/>
					<Attributes/>
					<Features/>
				</Label>
			</Components>
			<Events/>
			<TableParameters/>
			<JoinTables/>
			<JoinLinks/>
			<Fields/>
			<SPParameters/>
			<SQLParameters/>
			<SecurityGroups/>
			<Attributes/>
			<Features/>
		</Grid>
	</Components>
	<CodeFiles>
		<CodeFile id="Code" language="PHPTemplates" name="service.php" forShow="True" url="service.php" comment="//" codePage="windows-1252"/>
		<CodeFile id="Code" language="ASPTemplates" name="service.asp" forShow="True" url="service.asp" comment="'" codePage="windows-1252"/>
</CodeFiles>
	<SecurityGroups/>
	<CachingParameters/>
	<Attributes/>
	<Features/>
	<Events/>
</Page>
