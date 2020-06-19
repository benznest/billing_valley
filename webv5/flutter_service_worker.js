'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "11c120fd350b6404c7cd73c84b0f03b1",
"assets/assets/icons/boy_1.png": "96be0c0c3bc391e81b2cbcd40602ff88",
"assets/assets/icons/boy_10.png": "22e8c795b301861ed8afdd44de4b346b",
"assets/assets/icons/boy_11.png": "b407e80cc79da2073489f55fdb34a176",
"assets/assets/icons/boy_12.png": "cf31ee215838c2643340a67478f2c9f9",
"assets/assets/icons/boy_13.png": "e2b36191889d497b0d1f27800f8a76f7",
"assets/assets/icons/boy_14.png": "32aa3d50feea0d90e8f25839a5bbc336",
"assets/assets/icons/boy_2.png": "061d23f23fb03916efaf112877e6aca1",
"assets/assets/icons/boy_3.png": "f8dafb37940d663ae1ae2e5f087d2ead",
"assets/assets/icons/boy_4.png": "e656ad89e6a5f8fcd2bef6407e02fb6b",
"assets/assets/icons/boy_5.png": "19f951c510f15bda2a1ce32f09ad2ae3",
"assets/assets/icons/boy_6.png": "85bc097d5d11ee3bef7b063823ba559f",
"assets/assets/icons/boy_7.png": "31783529193c40735515a04f9f1c314a",
"assets/assets/icons/boy_8.png": "1f130882946c9bf92be95e0437094861",
"assets/assets/icons/boy_9.png": "61a1c027c1655281308c3e83ebbb2e35",
"assets/assets/icons/breakfast.png": "d7b0ab18ee966beecd4b76330eb40d1e",
"assets/assets/icons/carbohydrates.png": "7f16cbd71f3c9ea7bac7f7da6996d150",
"assets/assets/icons/egg.png": "29062d8a500a934581e16ad3407dc6e6",
"assets/assets/icons/food.png": "e52894a42739b9aa743a10f8dd7801c7",
"assets/assets/icons/food_delivery.png": "0aff5723980a7c219582a69cd1351a9f",
"assets/assets/icons/girl.png": "3d5b13c92201452a74274aaa2f66b493",
"assets/assets/icons/girl_1.png": "3d5b13c92201452a74274aaa2f66b493",
"assets/assets/icons/girl_10.png": "ff90e806d19c3c139575efb47e5d581a",
"assets/assets/icons/girl_11.png": "ba37ff0f17b761acc915bb08d0ddc439",
"assets/assets/icons/girl_12.png": "42e544e27d541bbd73d6f6ecc3c2340b",
"assets/assets/icons/girl_13.png": "c79e580296d6ac1adf0145d3a0f0bd76",
"assets/assets/icons/girl_14.png": "8fb7dae3b9563c94ca00b47484884846",
"assets/assets/icons/girl_2.png": "8d6b60704cdf350a269a7cd0467dbc2c",
"assets/assets/icons/girl_3.png": "b70d28b04be236b97941bc9a22cefc17",
"assets/assets/icons/girl_4.png": "ee5034619742633927bb17edca365e5d",
"assets/assets/icons/girl_5.png": "89113a04342860b75be5892993ae1486",
"assets/assets/icons/girl_6.png": "1ff34c6f6c2349ab2960c70c371e33cb",
"assets/assets/icons/girl_7.png": "da9a82ce37c1e9889185ec977292528d",
"assets/assets/icons/girl_8.png": "facdb2570d4f9a150b72aadc8f6c3cdf",
"assets/assets/icons/girl_9.png": "79c8e7c06cf84617c5ec6984dacff231",
"assets/assets/icons/meal.png": "546f5ec213ea5f4fca95be97f8bf445d",
"assets/assets/icons/meat.png": "2dcf66807161983fd0a5f35b7ef6a088",
"assets/assets/icons/sale.png": "10af5aec362b452e2cc2be9a9918b60d",
"assets/assets/icons/sandwich.png": "4f1aec8c0395ca0a7045aaa485b9f9a7",
"assets/assets/icons/team.png": "5afbdece032827f1a9767eb242cfe301",
"assets/FontManifest.json": "01700ba55b08a6141f33e168c4a6c22f",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/NOTICES": "41ef8419084ed9142556aff5bd21f498",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"favicon.png": "d5229c38292973706b359598e9b9a23e",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "994dd69bf631e61ac584f204b522b6fb",
"/": "994dd69bf631e61ac584f204b522b6fb",
"main.dart.js": "08de49912dac005771923df249ce3af4",
"manifest.json": "a735002b19b5b7225ea42f55122775d9"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/LICENSE",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      // Provide a no-cache param to ensure the latest version is downloaded.
      return cache.addAll(CORE.map((value) => new Request(value, {'cache': 'no-cache'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');

      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }

      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#')) {
    key = '/';
  }
  // If the URL is not the the RESOURCE list, skip the cache.
  if (!RESOURCES[key]) {
    return event.respondWith(fetch(event.request));
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache. Ensure the resources are not cached
        // by the browser for longer than the service worker expects.
        var modifiedRequest = new Request(event.request, {'cache': 'no-cache'});
        return response || fetch(modifiedRequest).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.message == 'skipWaiting') {
    return self.skipWaiting();
  }

  if (event.message = 'downloadOffline') {
    downloadOffline();
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey in Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.add(resourceKey);
    }
  }
  return Cache.addAll(resources);
}
