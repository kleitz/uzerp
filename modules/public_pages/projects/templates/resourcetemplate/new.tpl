{** 
 *	(c) 2017 uzERP LLP (support#uzerp.com). All rights reserved. 
 * 
 *	Released under GPLv3 license; see LICENSE. 
 **}
{content_wrapper}
	{form controller="resourcetemplate" action="save"}
		{with model=$models.Resourcetemplate legend="Resource Details"}
			<dl id="view_data_left">
			{view_section heading="Resource_details"}
				{input type='hidden'  attribute='id' }
				{input type='hidden'  attribute='usercompanyid' }
				{include file='elements/auditfields.tpl' }
				{select attribute='person_id' }
				{input type='text' attribute='name'}
				{select attribute='mfresource_id' label = 'Resource'}
				{select attribute='resource_type_id'}
				
			{/view_section}
			{view_section heading="Resource_costs"}
				{input type='text'  attribute='standard_rate'}
				{input type='text'  attribute='overtime_rate'}
				
			{/view_section}
			{submit}
			</dl>
		{/with}
	{/form}
{/content_wrapper}
