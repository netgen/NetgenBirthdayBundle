<div class="content-view-full">
<div class="user user-register noleftcolumn rightcolumn">

    <div class="columns-frontpage float-break">
        <div class="center-column-position">
            <div class="center-column float-break">
                <div class="overflow-fix">
                <!-- Content: START -->

		<div class="attribute-header">
		    <h1 class="long">{"User registered"|i18n("dms/register/user")|upcase}</h1>
		</div>

		<div class="roundbox">
		<div class="scs-c scs-tl"></div><div class="scs-c scs-tr"></div><div class="scs-c scs-br"></div><div class="scs-c scs-bl"></div>

		{section show=$verify_user_email}

			<div class="feedback">
			<p>
			{'Your account was successfully created. An email will be sent to the specified email address. Follow the instructions in that mail to activate your account.'|i18n('dms/register/user')}
			</p>
			</div>
		{section-else}
			<div class="feedback">
			<h2>{"Your account was successfully created."|i18n("dms/register/user")}</h2>
			</div>
		{/section}

		</div>
                <!-- Content: END -->
                </div>
            </div>
        </div>
        <div class="right-column-position">
            <div class="right-column">
            <!-- Content: START -->
		{include uri='design:parts/right_column.tpl'}
            <!-- Content: END -->
            </div>
        </div>
    </div>

</div>
</div>
