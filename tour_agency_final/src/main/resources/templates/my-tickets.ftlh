<#import "blocks/template.ftlh" as t>
<@t.template user>
    <h1 style="text-align: center">Мои билеты</h1>
    <hr>
    <#list user.roles as role>
        <#if role == "ROLE_ADMIN">
            <a class="btn btn-info mt-3 mb-3" style="text-align: center; width: 100%"
               data-toggle="collapse" href="#collapseExample" role="button"
               aria-expanded="true" aria-controls="collapseExample">
                Добавить новый билет
            </a>
            <div class="collapse mb-3" id="collapseExample" style="">
                <form action="/ticket/create" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="ticketName">Название</label>
                        <input type="text" required class="form-control"
                               id="ticketName" name="title">
                    </div>
                    <div class="form-group">
                        <label for="price">Цена билета</label>
                        <div class="input-group mb-3">
                            <input type="number" required class="form-control" id="price" name="price">
                            <div class="input-group-append">
                                <span class="input-group-text">₽</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="searchDepCity">Город вылета</label>
                        <select id="searchDepCity" required name="depCity" class="form-control">
                            <option value="">Город не выбран</option>

                            <option value="Москва">Москва</option>
                            <option value="Санкт-Петербург">Санкт-Петербург</option>
                            <option value="Новосибирск">Новосибирск</option>
                            <option value="Екатеринбург">Екатеринбург</option>
                            <option value="Казань">Казань</option>
                            <option value="Нижний Новгород">Нижний Новгород</option>
                            <option value="Челябинск">Челябинск</option>
                            <option value="Самара">Самара</option>
                            <option value="Омск">Омск</option>
                            <option value="Ростов-на-Дону">Ростов-на-Дону</option>

                        </select>
                    </div>
                    <div class="form-group">
                        <label for="searchArrCity">Город прилета</label>
                        <select id="searchArrCity" required name="arrCity" class="form-control">
                            <option value="">Город не выбран</option>

                            <option value="Москва">Москва</option>
                            <option value="Санкт-Петербург">Санкт-Петербург</option>
                            <option value="Новосибирск">Новосибирск</option>
                            <option value="Екатеринбург">Екатеринбург</option>
                            <option value="Казань">Казань</option>
                            <option value="Нижний Новгород">Нижний Новгород</option>
                            <option value="Челябинск">Челябинск</option>
                            <option value="Самара">Самара</option>
                            <option value="Омск">Омск</option>
                            <option value="Ростов-на-Дону">Ростов-на-Дону</option>

                        </select>
                    </div>
                    <div class="form-group">
                        <label for="description">Описание</label>
                        <textarea class="form-control" id="description" name="description"></textarea>
                    </div>
                    <div class="form-group">
                        <div class="custom-file">
                            <input type="file" name="file1" id="file1">
                            <label class="custom-file-label" for="file1">Фотография 1</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="custom-file">
                            <input type="file" name="file2" id="file2">
                            <label class="custom-file-label" for="file2">Фотография 2</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="custom-file">
                            <input type="file" name="file3" id="file3">
                            <label class="custom-file-label" for="file3">Фотография 3</label>
                        </div>
                    </div>
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>

                    <button type="submit" style="width: 100%" class="btn btn-info">Добавить</button>
                </form>
            </div>
        </#if>
    </#list>
    <div class="card-columns">
        <#list tickets as ticket>
            <a href="/ticket/${ticket.id}?showButton=false" class="ticket-link">
                <div class="card text-white bg-info my-3 ticket">
                    <div class="card-top">
                        <form action="/ticket/delete/${ticket.id}" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                            <button type="submit" class="btn btn-danger m-3">
                                Удалить
                            </button>
                        </form>
                    </div>
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
            <h1 style="text-align: center">Пока билетов нет!</h1>
        </#list>
    </div>
</@t.template>