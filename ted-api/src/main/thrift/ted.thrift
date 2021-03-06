#!/usr/bin/env thrift --gen java:beans --gen py:new_style

namespace java nu.ted.generated

#  1) A client would not be able communicate with a service
#  2) Persisted data will need to be upgraded.
const i32	PROTOCOL_VERSION = 1

const i16	DEFAULT_PORT = 9030

struct Date {
	1: i64			value
}

struct SeriesSearchResult
{
	1: string searchUID,
	2: string name
}

enum EpisodeStatus
{
	UNKNOWN = 1,
	SEARCHING = 2,
	FOUND = 3,
	OLD = 4
}

struct Episode
{
	1: i16				season,
	2: i16				number,
	3: Date				aired,

	4: optional EpisodeStatus	status
}

struct Series
{
	1: i16			uid,
	2: string		name,
	3: Date			lastCheck,

	4: string		guideName,
	5: string		guideId,

	6: list<Episode>	episodes
}

struct TedConfig
{
	1: i16			port = DEFAULT_PORT	# Listening Port
}

struct Ted
{
	1: i32				version = PROTOCOL_VERSION,

	2: TedConfig		config,
	3: list<Series>		series
}

enum ImageType {
	BANNER = 1,
	BANNER_THUMBNAIL = 2
}

struct ImageFile
{
	1: string mimetype,
	2: binary data
}

enum EventType
{
	WATCHED_SERIES_ADDED = 1,
	WATCHED_SERIES_REMOVED = 2
}

struct Event
{
	1: EventType type,
	2: Series series
}

service TedService
{
	# Get the server protocol version
	i32 getVersion();

	# Find a show
	list<SeriesSearchResult> search(1: string name);
		# TODO: throws?

	# subscribe to the show
	# Returns the Ted-UID of the show.
	i16 startWatching(1: string searchUID);
		# TODO: throws? should be void and just throw?

	# unsubscribe to a show
	void stopWatching(1: i16 uID);
		# TODO: throws? should be void and just throw?

	# get a list of what you're currently subscribed to.
	list<Series> getWatching();
		# TODO: throws?

	# get a single serie by uID.
	Series getSeries(1: i16 uID);
		# TODO: throws?

	ImageFile getImageByGuideId(1: string searchUID, 2: ImageType type);
		# TODO: throws?

	ImageFile getImageBySeriesId(1: i16 uID, 2: ImageType type);
		# TODO: throws?

	string getOverview(1: string searchUID);
		# TODO: throws?

	string registerClientWithEventRegistry();
		# TODO: throws?

	list<Event> getEvents(1: string eventRegistryClientId);
		# TODO: throws?

}
