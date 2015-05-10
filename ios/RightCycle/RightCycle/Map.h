#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface Map : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>
   @property (strong, nonatomic) IBOutlet MKMapView *mapView;
@end
