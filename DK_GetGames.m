% Get Current Time
mDT = datetime('now','Timezone','Local');
% Set Web Options Timeout
options = weboptions('Timeout', 30,"ContentType", "json");
% Initialize Bet Table
allBs = [];
% Scrape Draftkings NFL Page
abc = webread('https://sportsbook.draftkings.com//sites/US-SB/api/v5/eventgroups/88808?format=json');
% Iterate over each Game
betTab = table();

warning('off')
for z = 1:length(abc.eventGroup.events)

    thisE = abc.eventGroup.events{z};
    gDT = datetime(string(thisE.startDate), 'InputFormat', 'uuuu-MM-dd''T''HH:mm:ss.SSSSSSXXX','Timezone','Local');
  % If Game has already started, skip it
    if gDT<= mDT; continue ;end
    betTab.StartDate(z,1) =gDT ;
    betTab.DT(1:height(betTab)) = mDT;
    betTab.League(z,1) = string(thisE.eventGroupName);
    % Run Parsing function
    [betTab] = DK_Parse(abc,thisE,betTab,z);
end
% height(betT)
allBs = [allBs;betTab];
betT = allBs(~ismissing(allBs.HomeT),:);
betT=sortrows(betT,'StartDate','ascend');
open('betT')



