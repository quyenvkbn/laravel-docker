<?php

namespace App\Http\Controllers;

use App\Jobs\TestJob;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Redis;

class TestController extends Controller
{
    public function test($type, $action){
        switch ($type) {
            case 'redis':
                $this->redis($action);
                break;
            case 'db':
                $this->db($action);
                break;
            case 'queue':
                $this->queue($action);
                break;
            default:
                dd("TEST is not support type: \"$type\", Type support: redis, db, queue");
        }
    }

    private function redis($action) {
        switch ($action) {
            case 'set':
                Redis::set("TEST", "TEST REDIS", "EX", 60);
                dd("Set REDIS key TEST 60s");

                break;
            case 'get':
                dd("Value: " . Redis::get("TEST"), "EX: " . Redis::TTL("TEST"));

                break;
            default:
                dd("TEST is not support action: \"$action\", Action support: set, get");
        }
    }

    private function db($action) {
        switch ($action) {
            case 'set':
                $result = User::updateOrCreate([
                    "id" => 1
                ], [
                    'id' => 1,
                    'name' => "TEST",
                    'email' => "test@gmail.com",
                    'email_verified_at' => now(),
                    'password' => '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',
                    'remember_token' => "Ye4oKoEa3Ro9llC",
                ]);
                dd($result);

                break;
            case 'get':
                dd(User::first());

                break;
            default:
                dd("TEST is not support action: \"$action\", Action support: set, get");
        }
    }

    private function queue($action) {
        switch ($action) {
            case 'set':
                $count = DB::table("jobs")->count();
                if ($count == 0) {
                    dispatch(new TestJob());
                    dd("Set job success");
                } else {
                    dd("Job is created");
                }

                break;
            case 'get':
                dd(DB::table("jobs")->get()->toArray());

                break;
            default:
                dd("TEST is not support action: \"$action\", Action support: set, get");
        }
    }
}
