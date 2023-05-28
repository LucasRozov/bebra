script_author("Lucas_Rozov")
script_name("Krutoi Bind")
script_version("28.05.2023")

-- https://github.com/qrlk/moonloader-script-updater
local enable_autoupdate = true -- false to disable auto-update + disable sending initial telemetry (server, moonloader version, script version, samp nickname, virtual volume serial number)
local autoupdate_loaded = false
local Update = nil
if enable_autoupdate then
    local updater_loaded, Updater = pcall(loadstring, [[return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=decodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion,m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('Загружено %d из %d.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('Загрузка обновления завершена.')sampAddChatMessage(b..'Обновление завершено!',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'Обновление прошло неудачно. Запускаю устаревшую версию..',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': Обновление не требуется.')if l.telemetry then local r=require"ffi"r.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local s=r.new("unsigned long[1]",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на '..c)update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout, выходим из ожидания проверки обновления. Смиритесь или проверьте самостоятельно на '..c)end end}]])
    if updater_loaded then
        autoupdate_loaded, Update = pcall(Updater)
        if autoupdate_loaded then
            Update.json_url = "https://raw.githubusercontent.com/LucasRozov/bebra/master/upd.json" .. tostring(os.clock())
            Update.prefix = "[" .. string.upper(thisScript().name) .. "]: "
            Update.url = "https://t.me/haydndc"
        end
    end
end

require "lib.moonloader"
local keys = require "vkeys"
local sampev = require 'lib.samp.events'
local effil = require('effil') -- подключаем библиотеку effil для отправки запросов
local encoding = require('encoding') -- подключаем библиотеку encoding для перевода текста из Windows-1251 в UTF-8
local u8 = encoding.UTF8
encoding.default = 'CP1251'
local imgui = require('imgui')
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8
local tag = "{696969}[BebraTools]{ffffff} » Бебра запущена."
local main_color = 0x696969
local imgui = require('imgui')

local window = imgui.ImBool(false)

local buffer = imgui.ImBuffer(256)

local fa = require 'fAwesome5'

local fa_font = nil
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig()
        font_config.MergeMode = true

        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fa-solid-900.ttf', 13.0, font_config, fa_glyph_ranges)
    end
end


function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
	  while not isSampAvailable() do wait(100) end
      sampAddChatMessage("" .. tag, main_color)
      sampRegisterChatCommand('fama', fama)
      sampRegisterChatCommand('fama1', fama1)
      sampRegisterChatCommand('sfa', sfa)
      sampRegisterChatCommand('invite', invite)
      sampRegisterChatCommand('uninvite', uninvite)
      sampRegisterChatCommand('fwarn', fwarn)
      sampRegisterChatCommand('unfwarn', fwarn)
      sampRegisterChatCommand('giverank', giverank)

      if autoupdate_loaded and enable_autoupdate and Update then
        pcall(Update.check, Update.json_url, Update.prefix, Update.url)
      end

	  while true do
	  wait(0)

      if window.v == false then
        imgui.Process = false
      end


if isKeyJustPressed(VK_NUMPAD6) and not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive() then sampSendChat("/balloon") end
   if isKeyJustPressed(VK_O) and not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive() then sampSendChat("/opengate") end
end
end

function apply_custom_style()
  imgui.SwitchContext()
  local style = imgui.GetStyle()
  local colors = style.Colors
  local clr = imgui.Col
  local ImVec4 = imgui.ImVec4
  local ImVec2 = imgui.ImVec2

   style.WindowPadding = ImVec2(15, 15)
   style.WindowRounding = 15.0
   style.FramePadding = ImVec2(5, 5)
   style.ItemSpacing = ImVec2(12, 8)
   style.ItemInnerSpacing = ImVec2(8, 6)
   style.IndentSpacing = 25.0
   style.ScrollbarSize = 15.0
   style.ScrollbarRounding = 15.0
   style.GrabMinSize = 15.0
   style.GrabRounding = 7.0
   style.ChildWindowRounding = 8.0
   style.FrameRounding = 6.0
 

     colors[clr.Text] = ImVec4(0.95, 0.96, 0.98, 1.00)
     colors[clr.TextDisabled] = ImVec4(0.36, 0.42, 0.47, 1.00)
     colors[clr.WindowBg] = ImVec4(0.11, 0.15, 0.17, 1.00)
     colors[clr.ChildWindowBg] = ImVec4(0.15, 0.18, 0.22, 1.00)
     colors[clr.PopupBg] = ImVec4(0.08, 0.08, 0.08, 0.94)
     colors[clr.Border] = ImVec4(0.43, 0.43, 0.50, 0.50)
     colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
     colors[clr.FrameBg] = ImVec4(0.20, 0.25, 0.29, 1.00)
     colors[clr.FrameBgHovered] = ImVec4(0.12, 0.20, 0.28, 1.00)
     colors[clr.FrameBgActive] = ImVec4(0.09, 0.12, 0.14, 1.00)
     colors[clr.TitleBg] = ImVec4(0.09, 0.12, 0.14, 0.65)
     colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.00, 0.00, 0.51)
     colors[clr.TitleBgActive] = ImVec4(0.08, 0.10, 0.12, 1.00)
     colors[clr.MenuBarBg] = ImVec4(0.15, 0.18, 0.22, 1.00)
     colors[clr.ScrollbarBg] = ImVec4(0.02, 0.02, 0.02, 0.39)
     colors[clr.ScrollbarGrab] = ImVec4(0.20, 0.25, 0.29, 1.00)
     colors[clr.ScrollbarGrabHovered] = ImVec4(0.18, 0.22, 0.25, 1.00)
     colors[clr.ScrollbarGrabActive] = ImVec4(0.09, 0.21, 0.31, 1.00)
     colors[clr.ComboBg] = ImVec4(0.20, 0.25, 0.29, 1.00)
     colors[clr.CheckMark] = ImVec4(0.28, 0.56, 1.00, 1.00)
     colors[clr.SliderGrab] = ImVec4(0.28, 0.56, 1.00, 1.00)
     colors[clr.SliderGrabActive] = ImVec4(0.37, 0.61, 1.00, 1.00)
     colors[clr.Button] = ImVec4(0.20, 0.25, 0.29, 1.00)
     colors[clr.ButtonHovered] = ImVec4(0.28, 0.56, 1.00, 1.00)
     colors[clr.ButtonActive] = ImVec4(0.06, 0.53, 0.98, 1.00)
     colors[clr.Header] = ImVec4(0.20, 0.25, 0.29, 0.55)
     colors[clr.HeaderHovered] = ImVec4(0.26, 0.59, 0.98, 0.80)
     colors[clr.HeaderActive] = ImVec4(0.26, 0.59, 0.98, 1.00)
     colors[clr.ResizeGrip] = ImVec4(0.26, 0.59, 0.98, 0.25)
     colors[clr.ResizeGripHovered] = ImVec4(0.26, 0.59, 0.98, 0.67)
     colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
     colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
     colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
     colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
     colors[clr.PlotLines] = ImVec4(0.61, 0.61, 0.61, 1.00)
     colors[clr.PlotLinesHovered] = ImVec4(1.00, 0.43, 0.35, 1.00)
     colors[clr.PlotHistogram] = ImVec4(0.90, 0.70, 0.00, 1.00)
     colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
     colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
     colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
end
apply_custom_style()


function sampev.onServerMessage(color, text)

  SendWebhook('https://discord.com/api/webhooks/1093201272951283763/pWvt53-0i8zimVFZAQ3GvYCEZLvM-w7m42PmvPxFuHqhRWfdev4eIxytodaIqznhNGYM', ([[{
    "content": "%s %s",
    "embeds": null,
    "attachments": []
  }]]):format(os.date('%Y-%m-%d %H:%M:%S'), text))

    local MyId = select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))
    local MyName = sampGetPlayerNickname(MyId)
    local NickBuyer, Tovar = text:match('(%a+_%a+) купил у вас (.*)')
      if NickBuyer and Tovar then
      lua_thread.create(function()
      SendWebhook('https://discord.com/api/webhooks/1088164069598580796/A59h6OeoIHnUTTcgh8CuYZdbg2hdJR2L6VbEvPxNVVM4dPH7PpuIjFVREGnTx3f2uLHc', ([[{
        "content": "<@765572799749816342>",
        "embeds": [
          {
            "title": "%s[%d], у вас купили товар!",
            "description": "%s купил у вас **«%s»**",
            "color": 6908265,
            "author": {
              "name": "BebraTools",
              "url": "https://vk.com/lucasrozov",
              "icon_url": "https://i.imgur.com/qfBqsPQ.png"
            },
            "footer": {
              "text": "Central Market BOT # 2023"
            }
          }
        ],
        "attachments": []
      }]]):format(MyName, MyId, NickBuyer, Tovar))
      wait(100)
      sampAddChatMessage('{696969}[BebraTools]{ffffff} » Сообщение в дискорд отправлено!', 0x696969)
      end)
    end

    local MyId = select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))
    local MyName = sampGetPlayerNickname(MyId)
    local Tovar = text:match('Вы купили (.*)')
      if Tovar then
      lua_thread.create(function()
      SendWebhook('https://discord.com/api/webhooks/1088164069598580796/A59h6OeoIHnUTTcgh8CuYZdbg2hdJR2L6VbEvPxNVVM4dPH7PpuIjFVREGnTx3f2uLHc', ([[{
        "content": "<@765572799749816342>",
        "embeds": [
          {
            "title": "%s[%d], вы купили товар!",
            "description": "Вы купили **«%s»**",
            "color": 6908265,
            "author": {
              "name": "BebraTools",
              "url": "https://vk.com/lucasrozov",
              "icon_url": "https://i.imgur.com/qfBqsPQ.png"
            },
            "footer": {
              "text": "Central Market BOT # 2023"
            }
          }
        ],
        "attachments": []
      }]]):format(MyName, MyId, Tovar))
      wait(100)
      sampAddChatMessage('{696969}[BebraTools]{ffffff} » Сообщение в дискорд отправлено!', 0x696969)
      end)
    end

end


function SendWebhook(URL, DATA, callback_ok, callback_error) -- Функция отправки запроса
  local function asyncHttpRequest(method, url, args, resolve, reject)
      local request_thread = effil.thread(function (method, url, args)
         local requests = require 'requests'
         local result, response = pcall(requests.request, method, url, args)
         if result then
            response.json, response.xml = nil, nil
            return true, response
         else
            return false, response
         end
      end)(method, url, args)
      if not resolve then resolve = function() end end
      if not reject then reject = function() end end
      lua_thread.create(function()
          local runner = request_thread
          while true do
              local status, err = runner:status()
              if not err then
                  if status == 'completed' then
                      local result, response = runner:get()
                      if result then
                         resolve(response)
                      else
                         reject(response)
                      end
                      return
                  elseif status == 'canceled' then
                      return reject(status)
                  end
              else
                  return reject(err)
              end
              wait(0)
          end
      end)
  end
  asyncHttpRequest('POST', URL, {headers = {['content-type'] = 'application/json'}, data = u8(DATA)}, callback_ok, callback_error)
end

function fama()
  lua_thread.create(function()
    sampSendChat('/fam Для нашей семьи есть скидки в разных бизнесах.')
    wait(5000)
    sampSendChat('/fam Подробнее о скидках - /fammenu > Информация о семье > Объявление.')
    wait(5000)
    sampSendChat('/fam У нашей фамы есть конфа в ВК, кто хочет вступить туда, отпишите в ВК @lucasrozov.')
    wait(5000)
    sampSendChat('/fam Выполняйте семейные квесты, т.к семья недавно была создана, она нуждается в репутации.')
    wait(5000)
    sampSendChat('/fam За репутацию будем покупать улучшения, в следствии чего будете получать плюшки.')
  end)
end
    
function imgui.OnDrawFrame()
  
    if window.v then
        local resX, resY = getScreenResolution()
        local sizeX, sizeY = 450, 350 -- WINDOW SIZE
        imgui.SetNextWindowPos(imgui.ImVec2(resX / 2 - sizeX / 2, resY / 2 - sizeY / 2), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowSize(imgui.ImVec2(sizeX, sizeY), imgui.Cond.FirstUseEver)
        imgui.Begin(fa.FIGHTER_JET .. u8' San - Fierro Army', window, imgui.WindowFlags.NoResize)
        imgui.Text(fa.HANDSHAKE_O .. u8' BebraTools приветствует Вас!')

        if imgui.CollapsingHeader(fa.INFO .. u8' Призыв') then
          if imgui.Button(u8' Начало') then
            sampSendChat('Здравия желаю, Вы пришли на призыв?')
          end
          imgui.SameLine()

          if imgui.Button(u8'Расскажите о себе') then
            lua_thread.create(function()
            sampSendChat('Хорошо, расскажите немного о себе.')
            end)
          end
          imgui.SameLine()

          if imgui.Button(u8'Документы') then
            lua_thread.create(function()
            sampSendChat('Отлично, тогда мне нужны Ваши документы, а именно: паспорт, лицензии и мед.карта.')
            wait(2000)
            sampSendChat('/b С отыгровками!')
            end)
          end
          imgui.SameLine()

          if imgui.Button(u8'Вопрос #1') then
            lua_thread.create(function()
            sampSendChat('Как вы понимаете слово "адекватность"?')
            end)
          end
          imgui.SameLine()

          if imgui.Button(u8'Вопрос #2') then
            lua_thread.create(function()
            sampSendChat('Опишите себя в трёх словах.')
            end)
          end

          if imgui.Button(fa.USER_PLUS .. u8'') then
            lua_thread.create(function()
            sampSendChat('Поздравляю, Вы нам подходите, ожидайте скоро выдам Вам форму.')
            end)
          end
          imgui.SameLine()

          if imgui.Button(fa.USER_TIMES .. u8'') then
            lua_thread.create(function()
            sampSendChat('К сожалению, Вы не годны.')
            end)
          end
        end

        if imgui.CollapsingHeader(fa.BOOK .. u8' Экзамен') then
          if imgui.Button(u8'Начало') then
            sampSendChat('Экзамен состоит с 2 этапов, опрос и задание, вы готовы?')
          end

          if imgui.Button(u8'Вопрос 1') then
            sampSendChat('Первый вопрос, с какого порядкового звания можно присутствовать на спец. операции "ПОРТ"?')
          end
          imgui.SameLine()
          imgui.Text(u8'Отв: с 1')

          if imgui.Button(u8'Вопрос 2') then
            sampSendChat('Второй вопрос, разрешено ли носить аксессуар "Череп на грудь"?')
          end
          imgui.SameLine()
          imgui.Text(u8'Отв: Да')

          if imgui.Button(u8'Вопрос 3') then
            sampSendChat('Третий вопрос, со скольки у нас начинается обеденный перерыв?')
          end
          imgui.SameLine()
          imgui.Text(u8'Отв: С 13:00')

          if imgui.Button(u8'Вопрос 4') then
            sampSendChat('Четвертый вопрос, во сколько начинаются обе спец. операции "ПОРТ"?')
          end
          imgui.SameLine()
          imgui.Text(u8'Отв: 14:50 | 19:50')

          if imgui.Button(u8'Вопрос 5') then
            sampSendChat('Пятый вопрос, имеете ли Вы право на продажу БП мафиям?')
          end
          imgui.SameLine()
          imgui.Text(u8'Отв: Нет')

          if imgui.Button(fa.USER_PLUS .. '') then
            lua_thread.create(function()
                sampSendChat('Поздравляю, Вы прошли первый этап, сейчас для вас будет второй этап, вы готовы?')
            end)
          end
          imgui.SameLine()

          if imgui.Button(fa.USER_TIMES .. '') then
            lua_thread.create(function()
                sampSendChat('К сожалению, вы не сдали первый этап, подготовьтесь и приходите еще раз')
            end)
          end

          imgui.Separator()

          imgui.Text(u8'Второй этап:')

          if imgui.Button(u8'Задание 1') then
            lua_thread.create(function()
              sampSendChat('Ваша задача залить масло в спец. транспорт "Patriot".')
              wait(2000)
              sampSendChat('/b Все действия должны фиксироваться скриншотами, после того..')
              wait(2000)
              sampSendChat('/b .. как Вы завершили задание, Вам нужно залить скриншоты на форум в спец. тему')
            end)
          end
          imgui.SameLine()

          if imgui.Button(u8'Задание 2') then
            lua_thread.create(function()
              sampSendChat('Ваша задача подкачать колёса в спец транспроте "Barracks".')
              wait(2000)
              sampSendChat('/b Все действия должны фиксироваться скриншотами, после того..')
              wait(2000)
              sampSendChat('/b .. как Вы завершили задание, Вам нужно залить скриншоты на форум в спец. тему')
            end)
          end
          imgui.SameLine()

          if imgui.Button(u8'Задание 3') then
            lua_thread.create(function()
              sampSendChat('Ваша задача перенести боеприпасы со склада в раздевалку, и положить в шкаф с вооружением.')
              wait(2000)
              sampSendChat('/b Все действия должны фиксироваться скриншотами, после того..')
              wait(2000)
              sampSendChat('/b .. как Вы завершили задание, Вам нужно залить скриншоты на форум в спец. тему')
            end)
          end


        end

        if imgui.CollapsingHeader(fa.ID_BADGE .. u8' Система повышения') then
          imgui.Text(u8'Юнга [1] - Матрос [2]')
          imgui.Text(u8'1. Изготовить на заводе 30 материалов.')
          imgui.Text(u8'2. Простоять на посту 30 минут.')
  
          imgui.Spacing()
          
          imgui.Text(u8'Матрос [2] - Ст. Матрос [3]')
          imgui.Text(u8'1. Изготовить на заводе 50 материалов.')
          imgui.Text(u8'2. Простоять на посту 50 минут.')
  
          imgui.Spacing()
          
          imgui.Text(u8'Ст. Матрос [3] - Боцман [4]')
          imgui.Text(u8'1. Изготовить на заводе 100 материалов.')
          imgui.Text(u8'2. Простоять на посту 90 минут.')
          imgui.Text(u8'3. Доставить 3 фуры с БП в СФПД/ФБР.')
  
          imgui.Spacing()
          
          imgui.Text(u8'Ст. Матрос [3] - Боцман [4]')
          imgui.Text(u8'1. Изготовить на заводе 130 материалов.')
          imgui.Text(u8'2. Простоять на посту 120 минут.')
          imgui.Text(u8'3. Доставить 6 фур с БП в СФПД/ФБР.')
        end

        
        if imgui.CollapsingHeader(fa.MICROPHONE .. u8' Рация') then
          imgui.Text(u8'Строи:')
          
          if imgui.Button(u8'Строй на порт') then
            lua_thread.create(function()
              sampSendChat('/r Всеобщее построение на палубе, летим на порт, готовность 5 минут!')
              wait(2000)
              sampSendChat('/r Кого не будет - выговор.')
            end)
          end
          imgui.SameLine()

          if imgui.Button(u8'Строй на выездную') then
            lua_thread.create(function()
              sampSendChat('/r Всеобщее построение на палубе, готовность 5 минут!')
              wait(2000)
              sampSendChat('/r Кого не будет - выговор.')
            end)
          end

          imgui.Text(u8'Департамент:')
          if imgui.Button(u8'[Delta] СФа - ЛСа (Brabus)') then
            lua_thread.create(function()
              sampSendChat('/d [СФа | Dep. Com. DF] - [ЛСа]: Заезжаю на вашу ВЧ, не стрелять по черному Brabus 700.')
            end)
          end
  
          if imgui.Button(u8'[Delta] СФа - ТСР (Brabus)') then
            lua_thread.create(function()
              sampSendChat('/d [СФа | Dep. Com. DF] - [ТСР]: Заезжаю на вашу ВЧ, не стрелять по черному Brabus 700.')
            end)
          end
  
          if imgui.Button(u8'[Delta] СФа - ЛСа (E63)') then
            lua_thread.create(function()
              sampSendChat('/d [СФа | Dep. Com. DF] - [ЛСа]: Заезжаю на вашу ВЧ, не стрелять по черному Mercerdes E63.')
            end)
          end
  
          if imgui.Button(u8'[Delta] СФа - ТСР (E63)') then
            lua_thread.create(function()
              sampSendChat('/d [СФа | Dep. Com. DF] - [ТСР]: Заезжаю на вашу ВЧ, не стрелять по черному Mercerdes E63.')
            end)
          end
  
          if imgui.Button(u8'[Delta] СФа - ЛСа (Maverick)') then
            lua_thread.create(function()
              sampSendChat('/d [СФа | Dep. Com. DF] - [ЛСа]: Залетаю в ваше воздушное пространство, не стрелять по вертолету "Maverick".')
            end)
          end
  
          if imgui.Button(u8'[Delta] СФа - ТСР (Maverick)') then
            lua_thread.create(function()
              sampSendChat('/d [СФа | Dep. Com. DF] - [ТСР]: Залетаю в ваше воздушное пространство, не стрелять по вертолету "Maverick".')
            end)
          end

        end

        if imgui.CollapsingHeader(fa.SITEMAP .. u8' [NEW] Рация департамента') then
          imgui.Text(fa.REFRESH .. u8' В разработке, мб даже вводить не буду 228845rt7458')
        end

        imgui.End()
    end
end

function sfa(arg)
  window.v = not window.v
  imgui.Process = window.v
end

function invite(param)
  local id = string.match(param, "(%d+)")
  if sampGetPlayerNickname(select(2,sampGetPlayerIdByCharHandle(PLAYER_PED))) == "Lucas_Rozov" then
    lua_thread.create(function()
      sampSendChat("/me достал из кармана телефон")
      wait(2000)
      sampSendChat("/me вошел в базу данныx San Fierro Army")
      wait(2000)
      sampSendChat("/me зашел в раздел «Военнослужащие»")
      wait(2000)
      sampSendChat("/me нажал кнопку «Добавить»")
      wait(2000)
      sampSendChat("/me ввел данные о новом военнослужащем")
      wait(2000)
      sampSendChat(string.format("/r В базу данных военнослужащих San Fierro Army был добавлен гражданин №%d.", id))
      wait(2000)
      sampSendChat("/me убрал телефон в карман")
      wait(2000)
      sampSendChat("/me сунув руку в карман, достал ключ от шкафчика")
      wait(2000)
      sampSendChat(string.format("/todo Вот, держите, шкафчик №%d, удачной службы!*передав ключ", id))
      wait(2000)
      sampSendChat(string.format("/invite %d", id))
    end)
  end

  if sampGetPlayerNickname(select(2,sampGetPlayerIdByCharHandle(PLAYER_PED))) == "Poli_Rozova" then
    lua_thread.create(function()
      sampSendChat("/me достала из кармана телефон")
      wait(2000)
      sampSendChat("/me вошла в базу данныx San Fierro Army")
      wait(2000)
      sampSendChat("/me зашла в раздел «Военнослужащие»")
      wait(2000)
      sampSendChat("/me нажала кнопку «Добавить»")
      wait(2000)
      sampSendChat("/me ввела данные о новом военнослужащем")
      wait(2000)
      sampSendChat(string.format("/r В базу данных военнослужащих San Fierro Army был добавлен гражданин №%d.", id))
      wait(2000)
      sampSendChat("/me убрала телефон в карман")
      wait(2000)
      sampSendChat("/me сунув руку в карман, достала ключ от шкафчика")
      wait(2000)
      sampSendChat(string.format("/todo Вот, держите, шкафчик №%d, удачной службы!*передав ключ", id))
      wait(2000)
      sampSendChat(string.format("/invite %d", id))
  end)
end
end


function uninvite(param)
  local id, reason = string.match(param, "(%d+) (.+)")
  if sampGetPlayerNickname(select(2,sampGetPlayerIdByCharHandle(PLAYER_PED))) == "Lucas_Rozov" then
    lua_thread.create(function()
      sampSendChat("/me достал из кармана телефон")
      wait(2000)
      sampSendChat("/me вошел в базу данныx San Fierro Army")
      wait(2000)
      sampSendChat("/me зашел в раздел «Военнослужащие»")
      wait(2000)
      sampSendChat("/me нажал кнопку «Удалить»")
      wait(2000)
      sampSendChat("/me убрал телефон в карман")
      wait(2000)
      sampSendChat(string.format("/r Военнослужащий с бейджиком №%d был уволен! Причина: %s", id, reason))
      wait(2000)
      sampSendChat(string.format("/uninvite %d %s", id, reason))
    end)
  end

  if sampGetPlayerNickname(select(2,sampGetPlayerIdByCharHandle(PLAYER_PED))) == "Poli_Rozova" then
    lua_thread.create(function()
      sampSendChat("/me достала из кармана телефон")
      wait(2000)
      sampSendChat("/me вошла в базу данныx San Fierro Army")
      wait(2000)
      sampSendChat("/me зашла в раздел «Военнослужащие»")
      wait(2000)
      sampSendChat("/me нажала кнопку «Удалить»")
      wait(2000)
      sampSendChat("/me убрала телефон в карман")
      wait(2000)
      sampSendChat(string.format("/r Военнослужащий с бейджиком №%d был уволен! Причина: %s", id, reason))
      wait(2000)
      sampSendChat(string.format("/uninvite %d %s", id, reason))
  end)
end
end

function fwarn(param)
  local id, reason = string.match(param, "(%d+) (.+)")
  if sampGetPlayerNickname(select(2,sampGetPlayerIdByCharHandle(PLAYER_PED))) == "Lucas_Rozov" then
    lua_thread.create(function()
          sampSendChat("/me достал из кармана телефон")
            wait(2000)
            sampSendChat("/me вошел в базу данныx San-Fierro Army")
            wait(2000)
            sampSendChat("/me зашел в раздел «Военнослужащие»")
            wait(2000)
            sampSendChat("/me нажал кнопку «Изменить»")
            wait(2000)
            sampSendChat("/me внес изменения в строке «Выговоры»")
            wait(2000)
            sampSendChat("/me убрал телефон в карман")
            wait(2000)
            sampSendChat(string.format("/r Военнослужащему с бейджиком №%d был выдан выговор! Причина: %s", id, reason))
            wait(2000)
            sampSendChat(string.format("/fwarn %d %s", id, reason))
    end)
  end

  if sampGetPlayerNickname(select(2,sampGetPlayerIdByCharHandle(PLAYER_PED))) == "Poli_Rozova" then
    lua_thread.create(function()
            sampSendChat("/me достала из кармана телефон")
            wait(2000)
            sampSendChat("/me вошла в базу данныx San-Fierro Army")
            wait(2000)
            sampSendChat("/me зашла в раздел «Военнослужащие»")
            wait(2000)
            sampSendChat("/me нажала кнопку «Изменить»")
            wait(2000)
            sampSendChat("/me внесла изменения в строке «Выговоры»")
            wait(2000)
            sampSendChat("/me убрала телефон в карман")
            wait(2000)
            sampSendChat(string.format("/r Военнослужащему с бейджиком №%d был выдан выговор! Причина: %s", id, reason))
            wait(2000)
            sampSendChat(string.format("/fwarn %d %s", id, reason))
  end)
end
end

function unfwarn(param)
  local id, reason = string.match(param, "(%d+) (.+)")
  if sampGetPlayerNickname(select(2,sampGetPlayerIdByCharHandle(PLAYER_PED))) == "Lucas_Rozov" then
    lua_thread.create(function()
      sampSendChat("/me достал из кармана телефон")
      wait(2000)
      sampSendChat("/me вошел в базу данныx San-Fierro Army")
      wait(2000)
      sampSendChat("/me зашел в раздел «Военнослужащие»")
      wait(2000)
      sampSendChat("/me нажал кнопку «Изменить»")
      wait(2000)
      sampSendChat("/me внес изменения в строке «Выговоры»")
      wait(2000)
      sampSendChat("/me убрал телефон в карман")
      wait(2000)
      sampSendChat(string.format("/r Военнослужащему с бейджиком №%d был снят выговор! Причина: %s", id, reason))
      wait(2000)
      sampSendChat(string.format("/unfwarn %d %s", id, reason))
    end)
  end

  if sampGetPlayerNickname(select(2,sampGetPlayerIdByCharHandle(PLAYER_PED))) == "Poli_Rozova" then
    lua_thread.create(function()
      sampSendChat("/me достала из кармана телефон")
      wait(2000)
      sampSendChat("/me вошла в базу данныx San-Fierro Army")
      wait(2000)
      sampSendChat("/me зашла в раздел «Военнослужащие»")
      wait(2000)
      sampSendChat("/me нажала кнопку «Изменить»")
      wait(2000)
      sampSendChat("/me внесла изменения в строке «Выговоры»")
      wait(2000)
      sampSendChat("/me убрала телефон в карман")
      wait(2000)
      sampSendChat(string.format("/r Военнослужащему с бейджиком №%d был снят выговор! Причина: %s", id, reason))
      wait(2000)
      sampSendChat(string.format("/unfwarn %d %s", id, reason))
  end)
end
end

function giverank(param)
  local id, rank = string.match(param, "(%d+) (%d+)")
  if sampGetPlayerNickname(select(2,sampGetPlayerIdByCharHandle(PLAYER_PED))) == "Lucas_Rozov" then
    lua_thread.create(function()
      sampSendChat("/me достал из кармана телефон")
            wait(2000)
            sampSendChat("/me вошел в базу данных San-Fierro Army")
            wait(2000)
            sampSendChat("/me зашел в раздел «Военнослужащие»")
            wait(2000)
            sampSendChat("/me нажал кнопку «Изменить»")
            wait(2000)
            sampSendChat("/me изменил данные о военнослужащем")
            wait(2000)
            sampSendChat("/me убрал телефон в карман")
            wait(2000)
            sampSendChat("/me сунув руку в карман, достал ключ от шкафчика")
            wait(2000)
            sampSendChat(string.format("/todo Вот, держите, шкафчик №%d, там лежит ваша новая форма*передав ключ", id))
            wait(2000)
            sampSendChat(string.format("/giverank %d %d", id, rank))
    end)
  end

  if sampGetPlayerNickname(select(2,sampGetPlayerIdByCharHandle(PLAYER_PED))) == "Poli_Rozova" then
    lua_thread.create(function()
      sampSendChat("/me достала из кармана телефон")
            wait(2000)
            sampSendChat("/me вошла в базу данных San-Fierro Army")
            wait(2000)
            sampSendChat("/me зашла в раздел «Военнослужащие»")
            wait(2000)
            sampSendChat("/me нажала кнопку «Изменить»")
            wait(2000)
            sampSendChat("/me изменила данные о военнослужащем")
            wait(2000)
            sampSendChat("/me убрала телефон в карман")
            wait(2000)
            sampSendChat("/me сунув руку в карман, достала ключ от шкафчика")
            wait(2000)
            sampSendChat(string.format("/todo Вот, держите, шкафчик №%d, там лежит ваша новая форма*передав ключ", id))
            wait(2000)
            sampSendChat(string.format("/giverank %d %d", id, rank))
  end)
end
end



fa = {
  ['GLASS'] = "\xEF\x80\x80",
['MUSIC'] = "\xEF\x80\x81",
['SEARCH'] = "\xEF\x80\x82",
['ENVELOPE_O'] = "\xEF\x80\x83",
['HEART'] = "\xEF\x80\x84",
['STAR'] = "\xEF\x80\x85",
['STAR_O'] = "\xEF\x80\x86",
['USER'] = "\xEF\x80\x87",
['FILM'] = "\xEF\x80\x88",
['TH_LARGE'] = "\xEF\x80\x89",
['TH'] = "\xEF\x80\x8A",
['TH_LIST'] = "\xEF\x80\x8B",
['CHECK'] = "\xEF\x80\x8C",
['TIMES'] = "\xEF\x80\x8D",
['SEARCH_PLUS'] = "\xEF\x80\x8E",
['SEARCH_MINUS'] = "\xEF\x80\x90",
['POWER_OFF'] = "\xEF\x80\x91",
['SIGNAL'] = "\xEF\x80\x92",
['COG'] = "\xEF\x80\x93",
['TRASH_O'] = "\xEF\x80\x94",
['HOME'] = "\xEF\x80\x95",
['FILE_O'] = "\xEF\x80\x96",
['CLOCK_O'] = "\xEF\x80\x97",
['ROAD'] = "\xEF\x80\x98",
['DOWNLOAD'] = "\xEF\x80\x99",
['ARROW_CIRCLE_O_DOWN'] = "\xEF\x80\x9A",
['ARROW_CIRCLE_O_UP'] = "\xEF\x80\x9B",
['INBOX'] = "\xEF\x80\x9C",
['PLAY_CIRCLE_O'] = "\xEF\x80\x9D",
['REPEAT'] = "\xEF\x80\x9E",
['REFRESH'] = "\xEF\x80\xA1",
['LIST_ALT'] = "\xEF\x80\xA2",
['LOCK'] = "\xEF\x80\xA3",
['FLAG'] = "\xEF\x80\xA4",
['HEADPHONES'] = "\xEF\x80\xA5",
['VOLUME_OFF'] = "\xEF\x80\xA6",
['VOLUME_DOWN'] = "\xEF\x80\xA7",
['VOLUME_UP'] = "\xEF\x80\xA8",
['QRCODE'] = "\xEF\x80\xA9",
['BARCODE'] = "\xEF\x80\xAA",
['TAG'] = "\xEF\x80\xAB",
['TAGS'] = "\xEF\x80\xAC",
['BOOK'] = "\xEF\x80\xAD",
['BOOKMARK'] = "\xEF\x80\xAE",
['PRINT'] = "\xEF\x80\xAF",
['CAMERA'] = "\xEF\x80\xB0",
['FONT'] = "\xEF\x80\xB1",
['BOLD'] = "\xEF\x80\xB2",
['ITALIC'] = "\xEF\x80\xB3",
['TEXT_HEIGHT'] = "\xEF\x80\xB4",
['TEXT_WIDTH'] = "\xEF\x80\xB5",
['ALIGN_LEFT'] = "\xEF\x80\xB6",
['ALIGN_CENTER'] = "\xEF\x80\xB7",
['ALIGN_RIGHT'] = "\xEF\x80\xB8",
['ALIGN_JUSTIFY'] = "\xEF\x80\xB9",
['LIST'] = "\xEF\x80\xBA",
['OUTDENT'] = "\xEF\x80\xBB",
['INDENT'] = "\xEF\x80\xBC",
['VIDEO_CAMERA'] = "\xEF\x80\xBD",
['PICTURE_O'] = "\xEF\x80\xBE",
['PENCIL'] = "\xEF\x81\x80",
['MAP_MARKER'] = "\xEF\x81\x81",
['ADJUST'] = "\xEF\x81\x82",
['TINT'] = "\xEF\x81\x83",
['PENCIL_SQUARE_O'] = "\xEF\x81\x84",
['SHARE_SQUARE_O'] = "\xEF\x81\x85",
['CHECK_SQUARE_O'] = "\xEF\x81\x86",
['ARROWS'] = "\xEF\x81\x87",
['STEP_BACKWARD'] = "\xEF\x81\x88",
['FAST_BACKWARD'] = "\xEF\x81\x89",
['BACKWARD'] = "\xEF\x81\x8A",
['PLAY'] = "\xEF\x81\x8B",
['PAUSE'] = "\xEF\x81\x8C",
['STOP'] = "\xEF\x81\x8D",
['FORWARD'] = "\xEF\x81\x8E",
['FAST_FORWARD'] = "\xEF\x81\x90",
['STEP_FORWARD'] = "\xEF\x81\x91",
['EJECT'] = "\xEF\x81\x92",
['CHEVRON_LEFT'] = "\xEF\x81\x93",
['CHEVRON_RIGHT'] = "\xEF\x81\x94",
['PLUS_CIRCLE'] = "\xEF\x81\x95",
['MINUS_CIRCLE'] = "\xEF\x81\x96",
['TIMES_CIRCLE'] = "\xEF\x81\x97",
['CHECK_CIRCLE'] = "\xEF\x81\x98",
['QUESTION_CIRCLE'] = "\xEF\x81\x99",
['INFO_CIRCLE'] = "\xEF\x81\x9A",
['CROSSHAIRS'] = "\xEF\x81\x9B",
['TIMES_CIRCLE_O'] = "\xEF\x81\x9C",
['CHECK_CIRCLE_O'] = "\xEF\x81\x9D",
['BAN'] = "\xEF\x81\x9E",
['ARROW_LEFT'] = "\xEF\x81\xA0",
['ARROW_RIGHT'] = "\xEF\x81\xA1",
['ARROW_UP'] = "\xEF\x81\xA2",
['ARROW_DOWN'] = "\xEF\x81\xA3",
['SHARE'] = "\xEF\x81\xA4",
['EXPAND'] = "\xEF\x81\xA5",
['COMPRESS'] = "\xEF\x81\xA6",
['PLUS'] = "\xEF\x81\xA7",
['MINUS'] = "\xEF\x81\xA8",
['ASTERISK'] = "\xEF\x81\xA9",
['EXCLAMATION_CIRCLE'] = "\xEF\x81\xAA",
['GIFT'] = "\xEF\x81\xAB",
['LEAF'] = "\xEF\x81\xAC",
['FIRE'] = "\xEF\x81\xAD",
['EYE'] = "\xEF\x81\xAE",
['EYE_SLASH'] = "\xEF\x81\xB0",
['EXCLAMATION_TRIANGLE'] = "\xEF\x81\xB1",
['PLANE'] = "\xEF\x81\xB2",
['CALENDAR'] = "\xEF\x81\xB3",
['RANDOM'] = "\xEF\x81\xB4",
['COMMENT'] = "\xEF\x81\xB5",
['MAGNET'] = "\xEF\x81\xB6",
['CHEVRON_UP'] = "\xEF\x81\xB7",
['CHEVRON_DOWN'] = "\xEF\x81\xB8",
['RETWEET'] = "\xEF\x81\xB9",
['SHOPPING_CART'] = "\xEF\x81\xBA",
['FOLDER'] = "\xEF\x81\xBB",
['FOLDER_OPEN'] = "\xEF\x81\xBC",
['ARROWS_V'] = "\xEF\x81\xBD",
['ARROWS_H'] = "\xEF\x81\xBE",
['BAR_CHART'] = "\xEF\x82\x80",
['TWITTER_SQUARE'] = "\xEF\x82\x81",
['FACEBOOK_SQUARE'] = "\xEF\x82\x82",
['CAMERA_RETRO'] = "\xEF\x82\x83",
['KEY'] = "\xEF\x82\x84",
['COGS'] = "\xEF\x82\x85",
['COMMENTS'] = "\xEF\x82\x86",
['THUMBS_O_UP'] = "\xEF\x82\x87",
['THUMBS_O_DOWN'] = "\xEF\x82\x88",
['STAR_HALF'] = "\xEF\x82\x89",
['HEART_O'] = "\xEF\x82\x8A",
['SIGN_OUT'] = "\xEF\x82\x8B",
['LINKEDIN_SQUARE'] = "\xEF\x82\x8C",
['THUMB_TACK'] = "\xEF\x82\x8D",
['EXTERNAL_LINK'] = "\xEF\x82\x8E",
['SIGN_IN'] = "\xEF\x82\x90",
['TROPHY'] = "\xEF\x82\x91",
['GITHUB_SQUARE'] = "\xEF\x82\x92",
['UPLOAD'] = "\xEF\x82\x93",
['LEMON_O'] = "\xEF\x82\x94",
['PHONE'] = "\xEF\x82\x95",
['SQUARE_O'] = "\xEF\x82\x96",
['BOOKMARK_O'] = "\xEF\x82\x97",
['PHONE_SQUARE'] = "\xEF\x82\x98",
['TWITTER'] = "\xEF\x82\x99",
['FACEBOOK'] = "\xEF\x82\x9A",
['GITHUB'] = "\xEF\x82\x9B",
['UNLOCK'] = "\xEF\x82\x9C",
['CREDIT_CARD'] = "\xEF\x82\x9D",
['RSS'] = "\xEF\x82\x9E",
['HDD_O'] = "\xEF\x82\xA0",
['BULLHORN'] = "\xEF\x82\xA1",
['BELL'] = "\xEF\x83\xB3",
['CERTIFICATE'] = "\xEF\x82\xA3",
['HAND_O_RIGHT'] = "\xEF\x82\xA4",
['HAND_O_LEFT'] = "\xEF\x82\xA5",
['HAND_O_UP'] = "\xEF\x82\xA6",
['HAND_O_DOWN'] = "\xEF\x82\xA7",
['ARROW_CIRCLE_LEFT'] = "\xEF\x82\xA8",
['ARROW_CIRCLE_RIGHT'] = "\xEF\x82\xA9",
['ARROW_CIRCLE_UP'] = "\xEF\x82\xAA",
['ARROW_CIRCLE_DOWN'] = "\xEF\x82\xAB",
['GLOBE'] = "\xEF\x82\xAC",
['WRENCH'] = "\xEF\x82\xAD",
['TASKS'] = "\xEF\x82\xAE",
['FILTER'] = "\xEF\x82\xB0",
['BRIEFCASE'] = "\xEF\x82\xB1",
['ARROWS_ALT'] = "\xEF\x82\xB2",
['USERS'] = "\xEF\x83\x80",
['LINK'] = "\xEF\x83\x81",
['CLOUD'] = "\xEF\x83\x82",
['FLASK'] = "\xEF\x83\x83",
['SCISSORS'] = "\xEF\x83\x84",
['FILES_O'] = "\xEF\x83\x85",
['PAPERCLIP'] = "\xEF\x83\x86",
['FLOPPY_O'] = "\xEF\x83\x87",
['SQUARE'] = "\xEF\x83\x88",
['BARS'] = "\xEF\x83\x89",
['LIST_UL'] = "\xEF\x83\x8A",
['LIST_OL'] = "\xEF\x83\x8B",
['STRIKETHROUGH'] = "\xEF\x83\x8C",
['UNDERLINE'] = "\xEF\x83\x8D",
['TABLE'] = "\xEF\x83\x8E",
['MAGIC'] = "\xEF\x83\x90",
['TRUCK'] = "\xEF\x83\x91",
['PINTEREST'] = "\xEF\x83\x92",
['PINTEREST_SQUARE'] = "\xEF\x83\x93",
['GOOGLE_PLUS_SQUARE'] = "\xEF\x83\x94",
['GOOGLE_PLUS'] = "\xEF\x83\x95",
['MONEY'] = "\xEF\x83\x96",
['CARET_DOWN'] = "\xEF\x83\x97",
['CARET_UP'] = "\xEF\x83\x98",
['CARET_LEFT'] = "\xEF\x83\x99",
['CARET_RIGHT'] = "\xEF\x83\x9A",
['COLUMNS'] = "\xEF\x83\x9B",
['SORT'] = "\xEF\x83\x9C",
['SORT_DESC'] = "\xEF\x83\x9D",
['SORT_ASC'] = "\xEF\x83\x9E",
['ENVELOPE'] = "\xEF\x83\xA0",
['LINKEDIN'] = "\xEF\x83\xA1",
['UNDO'] = "\xEF\x83\xA2",
['GAVEL'] = "\xEF\x83\xA3",
['TACHOMETER'] = "\xEF\x83\xA4",
['COMMENT_O'] = "\xEF\x83\xA5",
['COMMENTS_O'] = "\xEF\x83\xA6",
['BOLT'] = "\xEF\x83\xA7",
['SITEMAP'] = "\xEF\x83\xA8",
['UMBRELLA'] = "\xEF\x83\xA9",
['CLIPBOARD'] = "\xEF\x83\xAA",
['LIGHTBULB_O'] = "\xEF\x83\xAB",
['EXCHANGE'] = "\xEF\x83\xAC",
['CLOUD_DOWNLOAD'] = "\xEF\x83\xAD",
['CLOUD_UPLOAD'] = "\xEF\x83\xAE",
['USER_MD'] = "\xEF\x83\xB0",
['STETHOSCOPE'] = "\xEF\x83\xB1",
['SUITCASE'] = "\xEF\x83\xB2",
['BELL_O'] = "\xEF\x82\xA2",
['COFFEE'] = "\xEF\x83\xB4",
['CUTLERY'] = "\xEF\x83\xB5",
['FILE_TEXT_O'] = "\xEF\x83\xB6",
['BUILDING_O'] = "\xEF\x83\xB7",
['HOSPITAL_O'] = "\xEF\x83\xB8",
['AMBULANCE'] = "\xEF\x83\xB9",
['MEDKIT'] = "\xEF\x83\xBA",
['FIGHTER_JET'] = "\xEF\x83\xBB",
['BEER'] = "\xEF\x83\xBC",
['H_SQUARE'] = "\xEF\x83\xBD",
['PLUS_SQUARE'] = "\xEF\x83\xBE",
['ANGLE_DOUBLE_LEFT'] = "\xEF\x84\x80",
['ANGLE_DOUBLE_RIGHT'] = "\xEF\x84\x81",
['ANGLE_DOUBLE_UP'] = "\xEF\x84\x82",
['ANGLE_DOUBLE_DOWN'] = "\xEF\x84\x83",
['ANGLE_LEFT'] = "\xEF\x84\x84",
['ANGLE_RIGHT'] = "\xEF\x84\x85",
['ANGLE_UP'] = "\xEF\x84\x86",
['ANGLE_DOWN'] = "\xEF\x84\x87",
['DESKTOP'] = "\xEF\x84\x88",
['LAPTOP'] = "\xEF\x84\x89",
['TABLET'] = "\xEF\x84\x8A",
['MOBILE'] = "\xEF\x84\x8B",
['CIRCLE_O'] = "\xEF\x84\x8C",
['QUOTE_LEFT'] = "\xEF\x84\x8D",
['QUOTE_RIGHT'] = "\xEF\x84\x8E",
['SPINNER'] = "\xEF\x84\x90",
['CIRCLE'] = "\xEF\x84\x91",
['REPLY'] = "\xEF\x84\x92",
['GITHUB_ALT'] = "\xEF\x84\x93",
['FOLDER_O'] = "\xEF\x84\x94",
['FOLDER_OPEN_O'] = "\xEF\x84\x95",
['SMILE_O'] = "\xEF\x84\x98",
['FROWN_O'] = "\xEF\x84\x99",
['MEH_O'] = "\xEF\x84\x9A",
['GAMEPAD'] = "\xEF\x84\x9B",
['KEYBOARD_O'] = "\xEF\x84\x9C",
['FLAG_O'] = "\xEF\x84\x9D",
['FLAG_CHECKERED'] = "\xEF\x84\x9E",
['TERMINAL'] = "\xEF\x84\xA0",
['CODE'] = "\xEF\x84\xA1",
['REPLY_ALL'] = "\xEF\x84\xA2",
['STAR_HALF_O'] = "\xEF\x84\xA3",
['LOCATION_ARROW'] = "\xEF\x84\xA4",
['CROP'] = "\xEF\x84\xA5",
['CODE_FORK'] = "\xEF\x84\xA6",
['CHAIN_BROKEN'] = "\xEF\x84\xA7",
['QUESTION'] = "\xEF\x84\xA8",
['INFO'] = "\xEF\x84\xA9",
['EXCLAMATION'] = "\xEF\x84\xAA",
['SUPERSCRIPT'] = "\xEF\x84\xAB",
['SUBSCRIPT'] = "\xEF\x84\xAC",
['ERASER'] = "\xEF\x84\xAD",
['PUZZLE_PIECE'] = "\xEF\x84\xAE",
['MICROPHONE'] = "\xEF\x84\xB0",
['MICROPHONE_SLASH'] = "\xEF\x84\xB1",
['SHIELD'] = "\xEF\x84\xB2",
['CALENDAR_O'] = "\xEF\x84\xB3",
['FIRE_EXTINGUISHER'] = "\xEF\x84\xB4",
['ROCKET'] = "\xEF\x84\xB5",
['MAXCDN'] = "\xEF\x84\xB6",
['CHEVRON_CIRCLE_LEFT'] = "\xEF\x84\xB7",
['CHEVRON_CIRCLE_RIGHT'] = "\xEF\x84\xB8",
['CHEVRON_CIRCLE_UP'] = "\xEF\x84\xB9",
['CHEVRON_CIRCLE_DOWN'] = "\xEF\x84\xBA",
['HTML5'] = "\xEF\x84\xBB",
['CSS3'] = "\xEF\x84\xBC",
['ANCHOR'] = "\xEF\x84\xBD",
['UNLOCK_ALT'] = "\xEF\x84\xBE",
['BULLSEYE'] = "\xEF\x85\x80",
['ELLIPSIS_H'] = "\xEF\x85\x81",
['ELLIPSIS_V'] = "\xEF\x85\x82",
['RSS_SQUARE'] = "\xEF\x85\x83",
['PLAY_CIRCLE'] = "\xEF\x85\x84",
['TICKET'] = "\xEF\x85\x85",
['MINUS_SQUARE'] = "\xEF\x85\x86",
['MINUS_SQUARE_O'] = "\xEF\x85\x87",
['LEVEL_UP'] = "\xEF\x85\x88",
['LEVEL_DOWN'] = "\xEF\x85\x89",
['CHECK_SQUARE'] = "\xEF\x85\x8A",
['PENCIL_SQUARE'] = "\xEF\x85\x8B",
['EXTERNAL_LINK_SQUARE'] = "\xEF\x85\x8C",
['SHARE_SQUARE'] = "\xEF\x85\x8D",
['COMPASS'] = "\xEF\x85\x8E",
['CARET_SQUARE_O_DOWN'] = "\xEF\x85\x90",
['CARET_SQUARE_O_UP'] = "\xEF\x85\x91",
['CARET_SQUARE_O_RIGHT'] = "\xEF\x85\x92",
['EUR'] = "\xEF\x85\x93",
['GBP'] = "\xEF\x85\x94",
['USD'] = "\xEF\x85\x95",
['INR'] = "\xEF\x85\x96",
['JPY'] = "\xEF\x85\x97",
['RUB'] = "\xEF\x85\x98",
['KRW'] = "\xEF\x85\x99",
['BTC'] = "\xEF\x85\x9A",
['FILE'] = "\xEF\x85\x9B",
['FILE_TEXT'] = "\xEF\x85\x9C",
['SORT_ALPHA_ASC'] = "\xEF\x85\x9D",
['SORT_ALPHA_DESC'] = "\xEF\x85\x9E",
['SORT_AMOUNT_ASC'] = "\xEF\x85\xA0",
['SORT_AMOUNT_DESC'] = "\xEF\x85\xA1",
['SORT_NUMERIC_ASC'] = "\xEF\x85\xA2",
['SORT_NUMERIC_DESC'] = "\xEF\x85\xA3",
['THUMBS_UP'] = "\xEF\x85\xA4",
['THUMBS_DOWN'] = "\xEF\x85\xA5",
['YOUTUBE_SQUARE'] = "\xEF\x85\xA6",
['YOUTUBE'] = "\xEF\x85\xA7",
['XING'] = "\xEF\x85\xA8",
['XING_SQUARE'] = "\xEF\x85\xA9",
['YOUTUBE_PLAY'] = "\xEF\x85\xAA",
['DROPBOX'] = "\xEF\x85\xAB",
['STACK_OVERFLOW'] = "\xEF\x85\xAC",
['INSTAGRAM'] = "\xEF\x85\xAD",
['FLICKR'] = "\xEF\x85\xAE",
['ADN'] = "\xEF\x85\xB0",
['BITBUCKET'] = "\xEF\x85\xB1",
['BITBUCKET_SQUARE'] = "\xEF\x85\xB2",
['TUMBLR'] = "\xEF\x85\xB3",
['TUMBLR_SQUARE'] = "\xEF\x85\xB4",
['LONG_ARROW_DOWN'] = "\xEF\x85\xB5",
['LONG_ARROW_UP'] = "\xEF\x85\xB6",
['LONG_ARROW_LEFT'] = "\xEF\x85\xB7",
['LONG_ARROW_RIGHT'] = "\xEF\x85\xB8",
['APPLE'] = "\xEF\x85\xB9",
['WINDOWS'] = "\xEF\x85\xBA",
['ANDROID'] = "\xEF\x85\xBB",
['LINUX'] = "\xEF\x85\xBC",
['DRIBBBLE'] = "\xEF\x85\xBD",
['SKYPE'] = "\xEF\x85\xBE",
['FOURSQUARE'] = "\xEF\x86\x80",
['TRELLO'] = "\xEF\x86\x81",
['FEMALE'] = "\xEF\x86\x82",
['MALE'] = "\xEF\x86\x83",
['GRATIPAY'] = "\xEF\x86\x84",
['SUN_O'] = "\xEF\x86\x85",
['MOON_O'] = "\xEF\x86\x86",
['ARCHIVE'] = "\xEF\x86\x87",
['BUG'] = "\xEF\x86\x88",
['VK'] = "\xEF\x86\x89",
['WEIBO'] = "\xEF\x86\x8A",
['RENREN'] = "\xEF\x86\x8B",
['PAGELINES'] = "\xEF\x86\x8C",
['STACK_EXCHANGE'] = "\xEF\x86\x8D",
['ARROW_CIRCLE_O_RIGHT'] = "\xEF\x86\x8E",
['ARROW_CIRCLE_O_LEFT'] = "\xEF\x86\x90",
['CARET_SQUARE_O_LEFT'] = "\xEF\x86\x91",
['DOT_CIRCLE_O'] = "\xEF\x86\x92",
['WHEELCHAIR'] = "\xEF\x86\x93",
['VIMEO_SQUARE'] = "\xEF\x86\x94",
['TRY'] = "\xEF\x86\x95",
['PLUS_SQUARE_O'] = "\xEF\x86\x96",
['SPACE_SHUTTLE'] = "\xEF\x86\x97",
['SLACK'] = "\xEF\x86\x98",
['ENVELOPE_SQUARE'] = "\xEF\x86\x99",
['WORDPRESS'] = "\xEF\x86\x9A",
['OPENID'] = "\xEF\x86\x9B",
['UNIVERSITY'] = "\xEF\x86\x9C",
['GRADUATION_CAP'] = "\xEF\x86\x9D",
['YAHOO'] = "\xEF\x86\x9E",
['GOOGLE'] = "\xEF\x86\xA0",
['REDDIT'] = "\xEF\x86\xA1",
['REDDIT_SQUARE'] = "\xEF\x86\xA2",
['STUMBLEUPON_CIRCLE'] = "\xEF\x86\xA3",
['STUMBLEUPON'] = "\xEF\x86\xA4",
['DELICIOUS'] = "\xEF\x86\xA5",
['DIGG'] = "\xEF\x86\xA6",
['PIED_PIPER_PP'] = "\xEF\x86\xA7",
['PIED_PIPER_ALT'] = "\xEF\x86\xA8",
['DRUPAL'] = "\xEF\x86\xA9",
['JOOMLA'] = "\xEF\x86\xAA",
['LANGUAGE'] = "\xEF\x86\xAB",
['FAX'] = "\xEF\x86\xAC",
['BUILDING'] = "\xEF\x86\xAD",
['CHILD'] = "\xEF\x86\xAE",
['PAW'] = "\xEF\x86\xB0",
['SPOON'] = "\xEF\x86\xB1",
['CUBE'] = "\xEF\x86\xB2",
['CUBES'] = "\xEF\x86\xB3",
['BEHANCE'] = "\xEF\x86\xB4",
['BEHANCE_SQUARE'] = "\xEF\x86\xB5",
['STEAM'] = "\xEF\x86\xB6",
['STEAM_SQUARE'] = "\xEF\x86\xB7",
['RECYCLE'] = "\xEF\x86\xB8",
['CAR'] = "\xEF\x86\xB9",
['TAXI'] = "\xEF\x86\xBA",
['TREE'] = "\xEF\x86\xBB",
['SPOTIFY'] = "\xEF\x86\xBC",
['DEVIANTART'] = "\xEF\x86\xBD",
['SOUNDCLOUD'] = "\xEF\x86\xBE",
['DATABASE'] = "\xEF\x87\x80",
['FILE_PDF_O'] = "\xEF\x87\x81",
['FILE_WORD_O'] = "\xEF\x87\x82",
['FILE_EXCEL_O'] = "\xEF\x87\x83",
['FILE_POWERPOINT_O'] = "\xEF\x87\x84",
['FILE_IMAGE_O'] = "\xEF\x87\x85",
['FILE_ARCHIVE_O'] = "\xEF\x87\x86",
['FILE_AUDIO_O'] = "\xEF\x87\x87",
['FILE_VIDEO_O'] = "\xEF\x87\x88",
['FILE_CODE_O'] = "\xEF\x87\x89",
['VINE'] = "\xEF\x87\x8A",
['CODEPEN'] = "\xEF\x87\x8B",
['JSFIDDLE'] = "\xEF\x87\x8C",
['LIFE_RING'] = "\xEF\x87\x8D",
['CIRCLE_O_NOTCH'] = "\xEF\x87\x8E",
['REBEL'] = "\xEF\x87\x90",
['EMPIRE'] = "\xEF\x87\x91",
['GIT_SQUARE'] = "\xEF\x87\x92",
['GIT'] = "\xEF\x87\x93",
['HACKER_NEWS'] = "\xEF\x87\x94",
['TENCENT_WEIBO'] = "\xEF\x87\x95",
['QQ'] = "\xEF\x87\x96",
['WEIXIN'] = "\xEF\x87\x97",
['PAPER_PLANE'] = "\xEF\x87\x98",
['PAPER_PLANE_O'] = "\xEF\x87\x99",
['HISTORY'] = "\xEF\x87\x9A",
['CIRCLE_THIN'] = "\xEF\x87\x9B",
['HEADER'] = "\xEF\x87\x9C",
['PARAGRAPH'] = "\xEF\x87\x9D",
['SLIDERS'] = "\xEF\x87\x9E",
['SHARE_ALT'] = "\xEF\x87\xA0",
['SHARE_ALT_SQUARE'] = "\xEF\x87\xA1",
['BOMB'] = "\xEF\x87\xA2",
['FUTBOL_O'] = "\xEF\x87\xA3",
['TTY'] = "\xEF\x87\xA4",
['BINOCULARS'] = "\xEF\x87\xA5",
['PLUG'] = "\xEF\x87\xA6",
['SLIDESHARE'] = "\xEF\x87\xA7",
['TWITCH'] = "\xEF\x87\xA8",
['YELP'] = "\xEF\x87\xA9",
['NEWSPAPER_O'] = "\xEF\x87\xAA",
['WIFI'] = "\xEF\x87\xAB",
['CALCULATOR'] = "\xEF\x87\xAC",
['PAYPAL'] = "\xEF\x87\xAD",
['GOOGLE_WALLET'] = "\xEF\x87\xAE",
['CC_VISA'] = "\xEF\x87\xB0",
['CC_MASTERCARD'] = "\xEF\x87\xB1",
['CC_DISCOVER'] = "\xEF\x87\xB2",
['CC_AMEX'] = "\xEF\x87\xB3",
['CC_PAYPAL'] = "\xEF\x87\xB4",
['CC_STRIPE'] = "\xEF\x87\xB5",
['BELL_SLASH'] = "\xEF\x87\xB6",
['BELL_SLASH_O'] = "\xEF\x87\xB7",
['TRASH'] = "\xEF\x87\xB8",
['COPYRIGHT'] = "\xEF\x87\xB9",
['AT'] = "\xEF\x87\xBA",
['EYEDROPPER'] = "\xEF\x87\xBB",
['PAINT_BRUSH'] = "\xEF\x87\xBC",
['BIRTHDAY_CAKE'] = "\xEF\x87\xBD",
['AREA_CHART'] = "\xEF\x87\xBE",
['PIE_CHART'] = "\xEF\x88\x80",
['LINE_CHART'] = "\xEF\x88\x81",
['LASTFM'] = "\xEF\x88\x82",
['LASTFM_SQUARE'] = "\xEF\x88\x83",
['TOGGLE_OFF'] = "\xEF\x88\x84",
['TOGGLE_ON'] = "\xEF\x88\x85",
['BICYCLE'] = "\xEF\x88\x86",
['BUS'] = "\xEF\x88\x87",
['IOXHOST'] = "\xEF\x88\x88",
['ANGELLIST'] = "\xEF\x88\x89",
['CC'] = "\xEF\x88\x8A",
['ILS'] = "\xEF\x88\x8B",
['MEANPATH'] = "\xEF\x88\x8C",
['BUYSELLADS'] = "\xEF\x88\x8D",
['CONNECTDEVELOP'] = "\xEF\x88\x8E",
['DASHCUBE'] = "\xEF\x88\x90",
['FORUMBEE'] = "\xEF\x88\x91",
['LEANPUB'] = "\xEF\x88\x92",
['SELLSY'] = "\xEF\x88\x93",
['SHIRTSINBULK'] = "\xEF\x88\x94",
['SIMPLYBUILT'] = "\xEF\x88\x95",
['SKYATLAS'] = "\xEF\x88\x96",
['CART_PLUS'] = "\xEF\x88\x97",
['CART_ARROW_DOWN'] = "\xEF\x88\x98",
['DIAMOND'] = "\xEF\x88\x99",
['SHIP'] = "\xEF\x88\x9A",
['USER_SECRET'] = "\xEF\x88\x9B",
['MOTORCYCLE'] = "\xEF\x88\x9C",
['STREET_VIEW'] = "\xEF\x88\x9D",
['HEARTBEAT'] = "\xEF\x88\x9E",
['VENUS'] = "\xEF\x88\xA1",
['MARS'] = "\xEF\x88\xA2",
['MERCURY'] = "\xEF\x88\xA3",
['TRANSGENDER'] = "\xEF\x88\xA4",
['TRANSGENDER_ALT'] = "\xEF\x88\xA5",
['VENUS_DOUBLE'] = "\xEF\x88\xA6",
['MARS_DOUBLE'] = "\xEF\x88\xA7",
['VENUS_MARS'] = "\xEF\x88\xA8",
['MARS_STROKE'] = "\xEF\x88\xA9",
['MARS_STROKE_V'] = "\xEF\x88\xAA",
['MARS_STROKE_H'] = "\xEF\x88\xAB",
['NEUTER'] = "\xEF\x88\xAC",
['GENDERLESS'] = "\xEF\x88\xAD",
['FACEBOOK_OFFICIAL'] = "\xEF\x88\xB0",
['PINTEREST_P'] = "\xEF\x88\xB1",
['WHATSAPP'] = "\xEF\x88\xB2",
['SERVER'] = "\xEF\x88\xB3",
['USER_PLUS'] = "\xEF\x88\xB4",
['USER_TIMES'] = "\xEF\x88\xB5",
['BED'] = "\xEF\x88\xB6",
['VIACOIN'] = "\xEF\x88\xB7",
['TRAIN'] = "\xEF\x88\xB8",
['SUBWAY'] = "\xEF\x88\xB9",
['MEDIUM'] = "\xEF\x88\xBA",
['Y_COMBINATOR'] = "\xEF\x88\xBB",
['OPTIN_MONSTER'] = "\xEF\x88\xBC",
['OPENCART'] = "\xEF\x88\xBD",
['EXPEDITEDSSL'] = "\xEF\x88\xBE",
['BATTERY_FULL'] = "\xEF\x89\x80",
['BATTERY_THREE_QUARTERS'] = "\xEF\x89\x81",
['BATTERY_HALF'] = "\xEF\x89\x82",
['BATTERY_QUARTER'] = "\xEF\x89\x83",
['BATTERY_EMPTY'] = "\xEF\x89\x84",
['MOUSE_POINTER'] = "\xEF\x89\x85",
['I_CURSOR'] = "\xEF\x89\x86",
['OBJECT_GROUP'] = "\xEF\x89\x87",
['OBJECT_UNGROUP'] = "\xEF\x89\x88",
['STICKY_NOTE'] = "\xEF\x89\x89",
['STICKY_NOTE_O'] = "\xEF\x89\x8A",
['CC_JCB'] = "\xEF\x89\x8B",
['CC_DINERS_CLUB'] = "\xEF\x89\x8C",
['CLONE'] = "\xEF\x89\x8D",
['BALANCE_SCALE'] = "\xEF\x89\x8E",
['HOURGLASS_O'] = "\xEF\x89\x90",
['HOURGLASS_START'] = "\xEF\x89\x91",
['HOURGLASS_HALF'] = "\xEF\x89\x92",
['HOURGLASS_END'] = "\xEF\x89\x93",
['HOURGLASS'] = "\xEF\x89\x94",
['HAND_ROCK_O'] = "\xEF\x89\x95",
['HAND_PAPER_O'] = "\xEF\x89\x96",
['HAND_SCISSORS_O'] = "\xEF\x89\x97",
['HAND_LIZARD_O'] = "\xEF\x89\x98",
['HAND_SPOCK_O'] = "\xEF\x89\x99",
['HAND_POINTER_O'] = "\xEF\x89\x9A",
['HAND_PEACE_O'] = "\xEF\x89\x9B",
['TRADEMARK'] = "\xEF\x89\x9C",
['REGISTERED'] = "\xEF\x89\x9D",
['CREATIVE_COMMONS'] = "\xEF\x89\x9E",
['GG'] = "\xEF\x89\xA0",
['GG_CIRCLE'] = "\xEF\x89\xA1",
['TRIPADVISOR'] = "\xEF\x89\xA2",
['ODNOKLASSNIKI'] = "\xEF\x89\xA3",
['ODNOKLASSNIKI_SQUARE'] = "\xEF\x89\xA4",
['GET_POCKET'] = "\xEF\x89\xA5",
['WIKIPEDIA_W'] = "\xEF\x89\xA6",
['SAFARI'] = "\xEF\x89\xA7",
['CHROME'] = "\xEF\x89\xA8",
['FIREFOX'] = "\xEF\x89\xA9",
['OPERA'] = "\xEF\x89\xAA",
['INTERNET_EXPLORER'] = "\xEF\x89\xAB",
['TELEVISION'] = "\xEF\x89\xAC",
['CONTAO'] = "\xEF\x89\xAD",
['500PX'] = "\xEF\x89\xAE",
['AMAZON'] = "\xEF\x89\xB0",
['CALENDAR_PLUS_O'] = "\xEF\x89\xB1",
['CALENDAR_MINUS_O'] = "\xEF\x89\xB2",
['CALENDAR_TIMES_O'] = "\xEF\x89\xB3",
['CALENDAR_CHECK_O'] = "\xEF\x89\xB4",
['INDUSTRY'] = "\xEF\x89\xB5",
['MAP_PIN'] = "\xEF\x89\xB6",
['MAP_SIGNS'] = "\xEF\x89\xB7",
['MAP_O'] = "\xEF\x89\xB8",
['MAP'] = "\xEF\x89\xB9",
['COMMENTING'] = "\xEF\x89\xBA",
['COMMENTING_O'] = "\xEF\x89\xBB",
['HOUZZ'] = "\xEF\x89\xBC",
['VIMEO'] = "\xEF\x89\xBD",
['BLACK_TIE'] = "\xEF\x89\xBE",
['FONTICONS'] = "\xEF\x8A\x80",
['REDDIT_ALIEN'] = "\xEF\x8A\x81",
['EDGE'] = "\xEF\x8A\x82",
['CREDIT_CARD_ALT'] = "\xEF\x8A\x83",
['CODIEPIE'] = "\xEF\x8A\x84",
['MODX'] = "\xEF\x8A\x85",
['FORT_AWESOME'] = "\xEF\x8A\x86",
['USB'] = "\xEF\x8A\x87",
['PRODUCT_HUNT'] = "\xEF\x8A\x88",
['MIXCLOUD'] = "\xEF\x8A\x89",
['SCRIBD'] = "\xEF\x8A\x8A",
['PAUSE_CIRCLE'] = "\xEF\x8A\x8B",
['PAUSE_CIRCLE_O'] = "\xEF\x8A\x8C",
['STOP_CIRCLE'] = "\xEF\x8A\x8D",
['STOP_CIRCLE_O'] = "\xEF\x8A\x8E",
['SHOPPING_BAG'] = "\xEF\x8A\x90",
['SHOPPING_BASKET'] = "\xEF\x8A\x91",
['HASHTAG'] = "\xEF\x8A\x92",
['BLUETOOTH'] = "\xEF\x8A\x93",
['BLUETOOTH_B'] = "\xEF\x8A\x94",
['PERCENT'] = "\xEF\x8A\x95",
['GITLAB'] = "\xEF\x8A\x96",
['WPBEGINNER'] = "\xEF\x8A\x97",
['WPFORMS'] = "\xEF\x8A\x98",
['ENVIRA'] = "\xEF\x8A\x99",
['UNIVERSAL_ACCESS'] = "\xEF\x8A\x9A",
['WHEELCHAIR_ALT'] = "\xEF\x8A\x9B",
['QUESTION_CIRCLE_O'] = "\xEF\x8A\x9C",
['BLIND'] = "\xEF\x8A\x9D",
['AUDIO_DESCRIPTION'] = "\xEF\x8A\x9E",
['VOLUME_CONTROL_PHONE'] = "\xEF\x8A\xA0",
['BRAILLE'] = "\xEF\x8A\xA1",
['ASSISTIVE_LISTENING_SYSTEMS'] = "\xEF\x8A\xA2",
['AMERICAN_SIGN_LANGUAGE_INTERPRETING'] = "\xEF\x8A\xA3",
['DEAF'] = "\xEF\x8A\xA4",
['GLIDE'] = "\xEF\x8A\xA5",
['GLIDE_G'] = "\xEF\x8A\xA6",
['SIGN_LANGUAGE'] = "\xEF\x8A\xA7",
['LOW_VISION'] = "\xEF\x8A\xA8",
['VIADEO'] = "\xEF\x8A\xA9",
['VIADEO_SQUARE'] = "\xEF\x8A\xAA",
['SNAPCHAT'] = "\xEF\x8A\xAB",
['SNAPCHAT_GHOST'] = "\xEF\x8A\xAC",
['SNAPCHAT_SQUARE'] = "\xEF\x8A\xAD",
['PIED_PIPER'] = "\xEF\x8A\xAE",
['FIRST_ORDER'] = "\xEF\x8A\xB0",
['YOAST'] = "\xEF\x8A\xB1",
['THEMEISLE'] = "\xEF\x8A\xB2",
['GOOGLE_PLUS_OFFICIAL'] = "\xEF\x8A\xB3",
['FONT_AWESOME'] = "\xEF\x8A\xB4",
['HANDSHAKE_O'] = "\xEF\x8A\xB5",
['ENVELOPE_OPEN'] = "\xEF\x8A\xB6",
['ENVELOPE_OPEN_O'] = "\xEF\x8A\xB7",
['LINODE'] = "\xEF\x8A\xB8",
['ADDRESS_BOOK'] = "\xEF\x8A\xB9",
['ADDRESS_BOOK_O'] = "\xEF\x8A\xBA",
['ADDRESS_CARD'] = "\xEF\x8A\xBB",
['ADDRESS_CARD_O'] = "\xEF\x8A\xBC",
['USER_CIRCLE'] = "\xEF\x8A\xBD",
['USER_CIRCLE_O'] = "\xEF\x8A\xBE",
['USER_O'] = "\xEF\x8B\x80",
['ID_BADGE'] = "\xEF\x8B\x81",
['ID_CARD'] = "\xEF\x8B\x82",
['ID_CARD_O'] = "\xEF\x8B\x83",
['QUORA'] = "\xEF\x8B\x84",
['FREE_CODE_CAMP'] = "\xEF\x8B\x85",
['TELEGRAM'] = "\xEF\x8B\x86",
['THERMOMETER_FULL'] = "\xEF\x8B\x87",
['THERMOMETER_THREE_QUARTERS'] = "\xEF\x8B\x88",
['THERMOMETER_HALF'] = "\xEF\x8B\x89",
['THERMOMETER_QUARTER'] = "\xEF\x8B\x8A",
['THERMOMETER_EMPTY'] = "\xEF\x8B\x8B",
['SHOWER'] = "\xEF\x8B\x8C",
['BATH'] = "\xEF\x8B\x8D",
['PODCAST'] = "\xEF\x8B\x8E",
['WINDOW_MAXIMIZE'] = "\xEF\x8B\x90",
['WINDOW_MINIMIZE'] = "\xEF\x8B\x91",
['WINDOW_RESTORE'] = "\xEF\x8B\x92",
['WINDOW_CLOSE'] = "\xEF\x8B\x93",
['WINDOW_CLOSE_O'] = "\xEF\x8B\x94",
['BANDCAMP'] = "\xEF\x8B\x95",
['GRAV'] = "\xEF\x8B\x96",
['ETSY'] = "\xEF\x8B\x97",
['IMDB'] = "\xEF\x8B\x98",
['RAVELRY'] = "\xEF\x8B\x99",
['EERCAST'] = "\xEF\x8B\x9A",
['MICROCHIP'] = "\xEF\x8B\x9B",
['SNOWFLAKE_O'] = "\xEF\x8B\x9C",
['SUPERPOWERS'] = "\xEF\x8B\x9D",
['WPEXPLORER'] = "\xEF\x8B\x9E",
['MEETUP'] = "\xEF\x8B\xA0"
}