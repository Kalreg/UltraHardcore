function OnCriticalLogEvent(self, event, ...)
  local critical = select(2, ...)

  -- Critical hit!
  if GLOBAL_SETTINGS.showCritScreenMoveEffect then
    if critical == 'CRITICAL' then
        RotateScreenEffect()
    end
  end
end
