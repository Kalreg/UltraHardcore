function SetQuestDisplay(hideQuestFrame)
  if hideQuestFrame then
--[[ 
    QuestWatchFrame:Hide()
 ]]
    WatchFrame:Hide()
  else
--[[ 
    QuestWatchFrame:Show()
 ]]    
    WatchFrame:Show()
  end
end
