<#import "blocks/template.ftlh" as t>
<@t.template userByPrincipal>
    <h1 style="text-align: center">Информация о пользователе</h1>
    <hr>
    <div style="text-align: center">
            <img src="/static/images/avatar.png"
                 style="border:2px solid black; border-radius: 20px" height="120">
        <br>
        <br>
        <h2>${user.name}</h2>
        <br>
        Номер телефона: <b>${user.phoneNumber}</b>
    </div>
    <br>
    <hr>
    <h1 style="text-align: center">Билеты пользователя ${user.name}</h1>
    <br>
    <div class="card-columns">
        <#list tickets as ticket>
            <a href="/ticket/${ticket.id}" class="ticket-link">
                <div class="card text-white bg-info my-3 ticket">

                    <img src="/images/${ticket.previewImageId}"
                         class="card-img-top">
                    <div class="card-body">
                        <h5 class="card-title">${ticket.title}</h5>
                        <p class="card-text">${ticket.price} ₽</p>
                    </div>
                        <div class="card-footer">
                            <#if ticket.depCity?? && ticket.arrCity??>
                                ${ticket.depCity} - ${ticket.arrCity}
                            <#else>
                                Город не указан
                            </#if>
                        </div>
                </div>
            </a>
        <#else>
            <h1 style="text-align: center">Не найдено</h1>
        </#list>
    </div>
</@t.template>

