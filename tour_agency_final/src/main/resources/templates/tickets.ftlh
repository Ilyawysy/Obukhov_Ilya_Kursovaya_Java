<#import "blocks/template.ftlh" as t>
<@t.template user>
    <h1 style="text-align: center">Поиск билетов</h1><hr>
    <form method="get" action="/">
        <div class="form-row">
            <div class="form-group col-md-5">
                <label for="depCity">Город вылета</label>
                <select id="depCity" name="depCity" class="form-control">
                    <option value="">Город не выбран</option>
                    <option value="Москва" <#if depCity?? && depCity == "Москва">selected</#if>>Москва</option>
                    <option value="Казань" <#if depCity?? && depCity == "Казань">selected</#if>>Казань</option>
                    <option value="Санкт-Петербург" <#if depCity?? && depCity == "Санкт-Петербург">selected</#if>>Санкт-Петербург</option>
                    <option value="Новосибирск" <#if depCity?? && depCity == "Новосибирск">selected</#if>>Новосибирск</option>
                    <option value="Екатеринбург" <#if depCity?? && depCity == "Екатеринбург">selected</#if>>Екатеринбург</option>
                    <option value="Нижний Новгород" <#if depCity?? && depCity == "Нижний Новгород">selected</#if>>Нижний Новгород</option>
                    <option value="Челябинск" <#if depCity?? && depCity == "Челябинск">selected</#if>>Челябинск</option>
                    <option value="Самара" <#if depCity?? && depCity == "Самара">selected</#if>>Самара</option>
                    <option value="Омск" <#if depCity?? && depCity == "Омск">selected</#if>>Омск</option>
                    <option value="Ростов-на-Дону" <#if depCity?? && depCity == "Ростов-на-Дону">selected</#if>>Ростов-на-Дону</option>
                </select>
            </div>

            <div class="form-group col-md-5">
                <label for="arrCity">Город прилета</label>
                <select id="arrCity" name="arrCity" class="form-control">
                    <option value="">Город не выбран</option>
                    <option value="Москва" <#if depCity?? && depCity == "Москва">selected</#if>>Москва</option>
                    <option value="Казань" <#if depCity?? && depCity == "Казань">selected</#if>>Казань</option>
                    <option value="Санкт-Петербург" <#if arrCity?? && arrCity == "Санкт-Петербург">selected</#if>>Санкт-Петербург</option>
                    <option value="Новосибирск" <#if arrCity?? && arrCity == "Новосибирск">selected</#if>>Новосибирск</option>
                    <option value="Екатеринбург" <#if arrCity?? && arrCity == "Екатеринбург">selected</#if>>Екатеринбург</option>
                    <option value="Нижний Новгород" <#if arrCity?? && arrCity == "Нижний Новгород">selected</#if>>Нижний Новгород</option>
                    <option value="Челябинск" <#if arrCity?? && arrCity == "Челябинск">selected</#if>>Челябинск</option>
                    <option value="Самара" <#if arrCity?? && arrCity == "Самара">selected</#if>>Самара</option>
                    <option value="Омск" <#if arrCity?? && arrCity == "Омск">selected</#if>>Омск</option>
                    <option value="Ростов-на-Дону" <#if arrCity?? && arrCity == "Ростов-на-Дону">selected</#if>>Ростов-на-Дону</option>
                </select>
            </div>

            <div class="form-group col-md-5">
                <label for="minPrice">Минимальная цена</label>
                <input type="number" name="minPrice" <#if minPrice??>value="${minPrice}"</#if> class="form-control"
                       id="minPrice" placeholder="Введите минимальную цену">
            </div>

            <div class="form-group col-md-5">
                <label for="maxPrice">Максимальная цена</label>
                <input type="number" name="maxPrice" <#if maxPrice??>value="${maxPrice}"</#if> class="form-control"
                       id="maxPrice" placeholder="Введите максимальную цену">
            </div>
            <button style="width: 100%" type="submit" class="btn btn-info">Поиск</button>
        </div>
    </form>
    <hr>

    <!-- Grid system with Bootstrap for displaying 3 items per row -->
    <div class="row">
        <#list tickets as ticket>
            <div class="col-md-4">
                <a href="/ticket/${ticket.id}?showButton=true" class="ticket-link">
                    <div class="card text-white bg-info my-3 ticket">
                        <img src="/images/${ticket.previewImageId}" class="card-img-top">
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
            </div>
        <#else>
            <h1 style="text-align: center">Не найдено</h1>
        </#list>
    </div>
</@t.template>