-- Path of Building
--
-- Module: Update Check
-- Checks for updates
--
local connectionProtocol, proxyURL = ...

local updateAvailableMsg = "Update available!\n"
local updateCheckFailedMsg = "Update check failed!\n"

local xml = require("xml")
local sha1 = require("sha1")
local curl = require("lcurl.safe")
local lzip = require("lzip")

local globalRetryLimit = 10
local function downloadFileText(source, file)
    for i = 1, 5 do
        if i > 1 then
            ConPrintf("Retrying... (%d of 5)", i)
        end
        local text = ""
        local easy = curl.easy()
        local escapedUrl = source .. easy:escape(file)
        easy:setopt_url(escapedUrl)
        easy:setopt(curl.OPT_ACCEPT_ENCODING, "")
        if connectionProtocol then
            easy:setopt(curl.OPT_IPRESOLVE, connectionProtocol)
        end
        if proxyURL then
            easy:setopt(curl.OPT_PROXY, proxyURL)
        end
        easy:setopt_writefunction(function(data)
            text = text .. data
            return true
        end)
        local _, error = easy:perform()
        easy:close()
        if not error then
            return text
        end
        ConPrintf("Download failed (%s)", error:msg())
        if globalRetryLimit == 0 or i == 5 then
            return nil, error:msg()
        end
        globalRetryLimit = globalRetryLimit - 1
    end
end

local function downloadFile(source, file, outName)
    for i = 1, 5 do
        if i > 1 then
            ConPrintf("Retrying... (%d of 5)", i)
        end
        local easy = curl.easy()
        local escapedUrl = source .. easy:escape(file)
        easy:setopt_url(escapedUrl)
        easy:setopt(curl.OPT_ACCEPT_ENCODING, "")
        if connectionProtocol then
            easy:setopt(curl.OPT_IPRESOLVE, connectionProtocol)
        end
        if proxyURL then
            easy:setopt(curl.OPT_PROXY, proxyURL)
        end
        local file = io.open(outName, "wb+")
        easy:setopt_writefunction(file)
        local _, error = easy:perform()
        easy:close()
        file:close()
        if not error then
            return true
        end
        ConPrintf("Download failed (%s)", error:msg())
        if globalRetryLimit == 0 or i == 5 then
            return nil, error:msg()
        end
        globalRetryLimit = globalRetryLimit - 1
    end
    return true
end

ConPrintf("Checking for update...")

local scriptPath = GetScriptPath()
local runtimePath = GetRuntimePath()

-- Load and process local manifest
local localVer
local localPlatform, localBranch
local localFiles = {}
local localManXML = xml.LoadXMLFile(scriptPath .. "/manifest.xml")
local localSource
local runtimeExecutable
if localManXML and localManXML[1].elem == "PoBVersion" then
    for _, node in ipairs(localManXML[1]) do
        if type(node) == "table" then
            if node.elem == "Version" then
                localVer = node.attrib.number
                localPlatform = node.attrib.platform
                localBranch = node.attrib.branch
            elseif node.elem == "Source" then
                if node.attrib.part == "default" then
                    localSource = node.attrib.url
                end
            elseif node.elem == "File" then
                local fullPath
                node.attrib.name = node.attrib.name:gsub("{space}", " ")
                if node.attrib.part == "runtime" then
                    fullPath = runtimePath .. "/" .. node.attrib.name
                else
                    fullPath = scriptPath .. "/" .. node.attrib.name
                end
                localFiles[node.attrib.name] = {
                    sha1 = node.attrib.sha1,
                    part = node.attrib.part,
                    platform = node.attrib.platform,
                    fullPath = fullPath,
                }
                if node.attrib.part == "runtime" and node.attrib.name:match("Path of Building") then
                    runtimeExecutable = fullPath
                end
            end
        end
    end
end
if not localVer or not localSource or not localBranch or not next(localFiles) then
    ConPrintf("Update check failed: invalid local manifest")
    return nil, updateCheckFailedMsg .. "Invalid local manifest"
end
localSource = localSource:gsub("{branch}", localBranch)

-- Download and process remote manifest
local remoteVer
local remoteManText, errMsg = downloadFileText(localSource, "manifest.xml")
if not remoteManText then
    ConPrintf("Update check failed: could not download version manifest")
    return nil,
        updateCheckFailedMsg
            .. "Could not download version manifest.\nReason: "
            .. errMsg
            .. "\nCheck your internet connectivity.\nIf you are using a proxy, specify it in Options."
end
local remoteManXML = xml.ParseXML(remoteManText)
if remoteManXML and remoteManXML[1].elem == "PoBVersion" then
    for _, node in ipairs(remoteManXML[1]) do
        if type(node) == "table" then
            if node.elem == "Version" then
                remoteVer = node.attrib.number
            end
        end
    end
end
if not remoteVer then
    ConPrintf("Update check failed: invalid remote manifest")
    return nil, updateCheckFailedMsg .. "Invalid remote manifest"
end

-- Display notification if there is an update available.
-- On NixOS it cannot be applied automatically, so the package version has to be updated manually.
if remoteVer > localVer then
    return nil, updateAvailableMsg .. "Latest version: " .. remoteVer .. "\nUpdate your nix package you lazy fuck!"
end
