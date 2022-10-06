function [betTab] = DK_Parse(abc,thisE,betTab,i)
%%
betTab.HomeT(i,1) = string(thisE.teamName1);
betTab.AwayT(i,1) = string(thisE.teamName2);
betTab.EventID(i,1) =string(thisE.eventId);
% betTab.PEventID(i,1) =string(thisE.providerEventId);
sz = size(abc.eventGroup.offerCategories{1, 1}.offerSubcategoryDescriptors{1, 1}.offerSubcategory.offers);
isDone =0;
if sz(2) == 3
    tempTab = struct2table(abc.eventGroup.offerCategories{1, 1}.offerSubcategoryDescriptors{1, 1}.offerSubcategory.offers(i,1).outcomes);
    isDone = 1;
    myType = 1;
    % If Struct
elseif isequal(class(abc.eventGroup.offerCategories{1, 1}.offerSubcategoryDescriptors{1, 1}.offerSubcategory.offers{i,1}),'struct') == 1
    myType = 2;
    tempTab =  struct2table(abc.eventGroup.offerCategories{1, 1}.offerSubcategoryDescriptors{1, 1}.offerSubcategory.offers{i,1}(1).outcomes)   ;   % Find The Correct Team?
 % If Cell
elseif isequal(class(abc.eventGroup.offerCategories{1, 1}.offerSubcategoryDescriptors{1, 1}.offerSubcategory.offers{i,1}),'cell') == 1
     myType = 3;
     tempTab =  struct2table(abc.eventGroup.offerCategories{1, 1}.offerSubcategoryDescriptors{1, 1}.offerSubcategory.offers{i,1}{1}.outcomes)   ;   % Find The Correct Team?
end
% myType
% Spread
if sum(contains(string(fields(tempTab)),'hidden'))>=1; else
 betTab.Line1(i,1) = tempTab.line(1);
 betTab.Odds1(i,1) = double(string(tempTab.oddsAmerican(1)));
 betTab.Line2(i,1) = tempTab.line(2);
 betTab.Odds2(i,1) = double(string(tempTab.oddsAmerican(2)));
 end
 % Moneylines
%  fprintf('No MLs\n'); 
 if myType == 1;tempTab =  struct2table(abc.eventGroup.offerCategories{1, 1}.offerSubcategoryDescriptors{1, 1}.offerSubcategory.offers(i,3).outcomes)  ;end
if myType == 2; tempTab =  struct2table(abc.eventGroup.offerCategories{1, 1}.offerSubcategoryDescriptors{1, 1}.offerSubcategory.offers{i,1}(3).outcomes)  ;end
if myType == 3;  tempTab =  struct2table(abc.eventGroup.offerCategories{1, 1}.offerSubcategoryDescriptors{1, 1}.offerSubcategory.offers{i,1}{3}.outcomes)   ; end
if sum(contains(string(fields(tempTab)),'hidden'))>=1; else
betTab.ML1(i,1) = double(string(tempTab.oddsAmerican(1)));
betTab.ML2(i,1) = double(string(tempTab.oddsAmerican(2)));
end
 % Totals
  if myType == 1;tempTab =  struct2table(abc.eventGroup.offerCategories{1, 1}.offerSubcategoryDescriptors{1, 1}.offerSubcategory.offers(i,2).outcomes)   ; end
if myType == 2;tempTab =  struct2table(abc.eventGroup.offerCategories{1, 1}.offerSubcategoryDescriptors{1, 1}.offerSubcategory.offers{i,1}(2).outcomes)   ; end
if myType == 3;  tempTab =  struct2table(abc.eventGroup.offerCategories{1, 1}.offerSubcategoryDescriptors{1, 1}.offerSubcategory.offers{i,1}{2}.outcomes)   ; end  % Find The Correct Team?
if sum(contains(string(fields(tempTab)),'hidden'))>=1;  return; end

betTab.Total(i,1) = tempTab.line(1);
betTab.OverOdds(i,1) = double(string(tempTab.oddsAmerican(1)));
betTab.UnderOdds(i,1) = double(string(tempTab.oddsAmerican(2)));
      
% betTab.Total(i,1) = tempTab.line(1);

% else

end

