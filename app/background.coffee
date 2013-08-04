config =
  QUERY_INTERVAL: 3
  UPDATE_INTERVAL: 60
  IDLE_THRESHOLD: 30
storageArea = chrome.storage.local

chrome.runtime.onInstalled.addListener (details) ->
  googleAuth = new OAuth2 'google',
    client_id: '50343319776-05t7b2687b6uq4e425oasfedoq043ank.apps.googleusercontent.com'
    client_secret: '_MqLaCWyacnUAEh6hdx5L-J0'
    api_scope: 'https://www.googleapis.com/auth/userinfo.email'

  googleAuth.authorize ->
    email = getEmail googleAuth.getAccessToken()
    registerUser email, googleAuth.getAccessToken()

getEmail = (access_token) ->
  request = new XMLHttpRequest()
  request.open 'GET', "https://www.googleapis.com/oauth2/v2/userinfo?access_token=#{access_token}", false
  request.send()
  if request.status == 200
    response = JSON.parse request.responseText
    response.email

registerUser = (email, access_token) ->
  console.log 'Registering user: ', email, access_token

queryBrowser = ->
  chrome.idle.queryState config.IDLE_THRESHOLD, (state) ->
    if state == 'active'
      queryInfo =
        active: true
        lastFocusedWindow: true
      chrome.tabs.query queryInfo, (tabs) ->
        if tabs.length
          activeTab = tabs[0]
          console.log activeTab.url
          updateLocal activeTab.url

updateLocal = (url) ->
  storageArea.get 'cache', (items) ->
    cache = items.cache ? {}
    cache[url] = 0 unless cache[url]?
    cache[url] += config.QUERY_INTERVAL
    storageArea.set cache: cache

updateServer = ->
  storageArea.get 'cache', (items) ->
    cache = items.cache
    if cache?
      console.log cache
      console.log 'Updating server'
      storageArea.remove 'cache'

setInterval queryBrowser, config.QUERY_INTERVAL * 1000
setInterval updateServer, config.UPDATE_INTERVAL * 1000
