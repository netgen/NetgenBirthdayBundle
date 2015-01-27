{if $validation.processed}
    {if or($validation.attributes,$validation.placement,$validation.custom_rules)}

      <div class="alert alert-danger">
      {if or(and($validation.attributes,$validation.placement),$validation.custom_rules)}
        <h4>{"Validation failed"|i18n("dms/content/validation")}</h4>
      {else}
        {if $validation.attributes}
        <h4>{"Input did not validate"|i18n("dms/content/validation")}</h4>
        {else}
        <h4>{"Location did not validate"|i18n("dms/content/validation")}</h4>
        {/if}
      {/if}
      <ul>
      {section name=UnvalidatedPlacements loop=$validation.placement show=$validation.placement}
        <li>{$:item.text|d18n('dms/dossier/edit')}</li>
      {/section}
      {section name=UnvalidatedAttributes loop=$validation.attributes show=$validation.attributes}
        <li>{$:item.name|wash|d18n('dms/dossier/edit')}: {$:item.description|d18n('dms/dossier/edit')}</li>
      {/section}
      {section name=UnvalidatedCustomRules loop=$validation.custom_rules show=$validation.custom_rules}
        <li>{$:item.text|d18n('dms/dossier/edit')}</li>
      {/section}
      </ul>
      </div>

    {else}
      {if $validation_log}
      <div class="alert alert-warning">
          <h4>{"Input was partially stored"|i18n("dms/content/validation")}</h4>
            {section name=ValidationLog loop=$validation_log}
                  <h5>{$:item.name|wash|d18n('dms/dossier/edit')}:</h5>
                  <ul>
                  {section name=LogMessage loop=$:item.description|d18n('dms/dossier/edit')}
                      <li>{$:item|d18n('dms/dossier/edit')}</li>
                  {/section}
                  </ul>
              {/section}
          </div>
      {else}
          <div class="alert alert-success">
          <h4>{"Input was stored successfully"|i18n("dms/content/validation")}</h4>
          </div>
      {/if}
    {/if}
{/if}
