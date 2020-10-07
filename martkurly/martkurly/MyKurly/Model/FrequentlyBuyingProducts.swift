//
//  FrequentlyBuyingProducts.swift
//  martkurly
//
//  Created by Kas Song on 10/7/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

struct FrequantlyBuyingProducts: Decodable {
    let goods_purchase_count: [Int]?
    let serializers: [Serializers]?

    struct Serializers: Decodable {
        let id: Int
    }
}

/*
{
    "goods_purchase_count" =     (
        1,
        1,
        1,
        1
    );
    serializers =     (
                {
            "discount_price" = "<null>";
            id = 4;
            img = "https://pbs-13-s3.s3.amazonaws.com/goods/%5BKF365%5D%20%EC%95%A0%ED%98%B8%EB%B0%95%201%EA%B0%9C/KF365_%EC%95%A0%ED%98%B8%EB%B0%95_1%EA%B0%9C_goods_image.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAXOLZAM2NBPACFGX7%2F20201007%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20201007T074520Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=c0bbf844deb42c980749c9ed2e5cece3c9072f28854b9525cc21ff20a503c736";
            "packing_status" = "\Ub0c9\Uc7a5";
            price = 2980;
            sales = "<null>";
            "sales_count" = 81;
            "short_desc" = "\Ubbff\Uace0 \Uba39\Uc744 \Uc218 \Uc788\Ub294 \Uc0c1\Ud488\Uc744 \Ud569\Ub9ac\Uc801\Uc778 \Uac00\Uaca9\Uc5d0, KF365";
            stock =             {
                count = 57;
                id = 4;
                "updated_at" = "2020-08-31T18:04:21.463000Z";
            };
            tagging =             (
            );
            title = "[KF365] \Uc560\Ud638\Ubc15 1\Uac1c";
            transfer = "<null>";
        },
                {
            "discount_price" = "<null>";
            id = 1;
            img = "https://pbs-13-s3.s3.amazonaws.com/goods/%5BKF365%5D%20%ED%96%87%20%EA%B0%90%EC%9E%90%201kg/KF365_%ED%96%87_%EA%B0%90%EC%9E%90_1kg_goods_image.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAXOLZAM2NBPACFGX7%2F20201007%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20201007T074520Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=5f0dfcdff3372aaabff815f7bbe7b0a75051b82c7f430c663ebbdc2ad7edfc3b";
            "packing_status" = "\Uc0c1\Uc628";
            price = 2380;
            sales = "<null>";
            "sales_count" = 6;
            "short_desc" = "\Ubbff\Uace0 \Uba39\Uc744 \Uc218 \Uc788\Ub294 \Uc0c1\Ud488\Uc744 \Ud569\Ub9ac\Uc801\Uc778 \Uac00\Uaca9\Uc5d0, KF365";
            stock =             {
                count = 82;
                id = 1;
                "updated_at" = "2020-08-18T18:05:16.687000Z";
            };
            tagging =             (
            );
            title = "[KF365] \Ud587 \Uac10\Uc790 1kg";
            transfer = "\Uc0db\Ubcc4\Ubc30\Uc1a1/\Ud0dd\Ubc30\Ubc30\Uc1a1";
        },
                {
            "discount_price" = 700;
            id = 2;
            img = "https://pbs-13-s3.s3.amazonaws.com/goods/%ED%95%9C%EB%81%BC%20%EB%8B%B9%EA%B7%BC%201%EA%B0%9C/%ED%95%9C%EB%81%BC_%EB%8B%B9%EA%B7%BC_1%EA%B0%9C_goods_image.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAXOLZAM2NBPACFGX7%2F20201007%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20201007T074520Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=8da7dbcc98a42ac7f615f75db5715d59c08710a4d70f8ab589f754bcabd5c1e7";
            "packing_status" = "\Ub0c9\Uc7a5";
            price = 1000;
            sales =             {
                contents = "<null>";
                "discount_rate" = 30;
            };
            "sales_count" = 68;
            "short_desc" = "\Ub531 \Ud558\Ub098\Ub9cc \Ud544\Uc694\Ud560 \Ub54c \Ud55c\Ub07c \Ub2f9\Uadfc";
            stock =             {
                count = 27;
                id = 2;
                "updated_at" = "2020-09-17T18:04:43.110000Z";
            };
            tagging =             (
            );
            title = "\Ud55c\Ub07c \Ub2f9\Uadfc 1\Uac1c";
            transfer = "\Uc0db\Ubcc4\Ubc30\Uc1a1/\Ud0dd\Ubc30\Ubc30\Uc1a1";
        },
                {
            "discount_price" = 1600;
            id = 3;
            img = "https://pbs-13-s3.s3.amazonaws.com/goods/GAP%20%EC%98%A4%EC%9D%B4%202%EC%9E%85/GAP_%EC%98%A4%EC%9D%B4_2%EC%9E%85_goods_image.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAXOLZAM2NBPACFGX7%2F20201007%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20201007T074520Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=580b6ea2fc3d35dc90cff9191bef7da4478614ac91128b064eb727d4bf9f633d";
            "packing_status" = "\Ub0c9\Uc7a5";
            price = 3200;
            sales =             {
                contents = "<null>";
                "discount_rate" = 50;
            };
            "sales_count" = 60;
            "short_desc" = "\Uc218\Ubd84\Uc774 \Uac00\Ub4dd\Ud55c \Uc5ec\Ub984 \Ucc44\Uc18c (1\Ubd09/2\Uc785)";
            stock =             {
                count = 80;
                id = 3;
                "updated_at" = "2020-08-04T18:04:39.518000Z";
            };
            tagging =             (
            );
            title = "GAP \Uc624\Uc774 2\Uc785";
            transfer = "\Uc0db\Ubcc4\Ubc30\Uc1a1/\Ud0dd\Ubc30\Ubc30\Uc1a1";
        }
    );
}
*/
