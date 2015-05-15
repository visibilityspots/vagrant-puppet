# Class: profiles::mongo
#
# This profile initializes the mongo service
class profiles::mongo {
    include repo::mongo
    include mongodb
}
