//executes on server
//converts data from HCs into a single array for use on the server with the module function

//params
params [["_who",objNull,[objNull]],["_amount",0,[0]],["_HCgroups",[],[[]]]];

//private variables
private ["_gg", "_whom", "_inWHKHeadlessArray"];

WHKHeadlessGroups append _HCgroups;

_gg = count _HCgroups;
While {_gg >0} do
{
	WHKHeadlessGroupOwners append [_who];
	_gg =_gg - 1;
};

_whom = owner _who;
_inWHKHeadlessArray = WHKHeadlessArray find _whom;
if (_inWHKHeadlessArray > -1) then
{
	WHKHeadlessLocalCounts set [_inWHKHeadlessArray,_amount];
	WHKHeadlessNames set [_inWHKHeadlessArray,_who];
}
else
{
	WHKHeadlessArray append [_whom];
	_inWHKHeadlessArray = WHKHeadlessArray find _whom;
	WHKHeadlessLocalCounts set [_inWHKHeadlessArray,_amount];
	WHKHeadlessNames set [_inWHKHeadlessArray,_who];
};