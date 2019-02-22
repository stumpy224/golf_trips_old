# Golf Trips

#### Rails Version
5.2.2

#### Ruby Version
2.5.1p57

#### UI
UI is based on [MDBootstrap](https://mdbootstrap.com)

## Golfers
Golfers is a model and table that is a complete listing of _all_ golfers whom have or will attend an Outing.
Golfer records are independent from User records, which is a separate model and table representing those who have
registered on Golf Hacker Club.

However, when a User updates their profile, these fields will be synced with their Golfer record given the
```User.email``` matches ```Golfer.email```:

- nickname
- email
- phone

## Create an Outing
Before an Outing can be created, a Course must exist as a Course is tied to an Outing.
When a Course is created, 18 Hole records are automatically created and tied to the Course, but the ```Hole.par``` and
```Hole.handicap``` values will need updated for correctness.

As a system convenience, when an Outing is created all **active** golfers will be added to the Outing.
As golfers indicate they cannot make the trip, the respective golfer can be removed from the Outing.

## Outing Documents
Outing documents are stored and maintained in Google Drive.  To display Outing documents on Golf Hacker Club,
the Google Drive folder **must match** the name of the Outing. Documents will also need to be converted to Google Docs
before they will be displayed. This can be accomplished by previewing the original document and clicking
```Open with Google Docs``` to convert. 

## Site Maintenance
The site can be placed in maintenance mode by updating the Admin Controls ```site_maintenance``` value to ON.
