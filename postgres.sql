-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table "Product"
--
-- ---

DROP TABLE IF EXISTS "Product";

CREATE TABLE "Product" (
  "id" INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  "name" VARCHAR NULL DEFAULT NULL,
  "slogan" VARCHAR NULL DEFAULT NULL,
  "description" VARCHAR NULL DEFAULT NULL,
  "category" VARCHAR NULL DEFAULT NULL,
  "default_price" VARCHAR NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

-- ---
-- Table "Features"
--
-- ---

DROP TABLE IF EXISTS "Features";

CREATE TABLE "Features" (
  "id" INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  "product_id" INTEGER NULL DEFAULT NULL,
  "feature" VARCHAR NULL DEFAULT NULL,
  "value" VARCHAR NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

-- ---
-- Table "Photos"
--
-- ---

DROP TABLE IF EXISTS "Photos";

CREATE TABLE "Photos" (
  "id" INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  "styleId" INTEGER NULL DEFAULT NULL,
  "thumbnail_url" TEXT NULL DEFAULT NULL,
  "url" TEXT NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

-- ---
-- Table "SKUs"
--
-- ---

DROP TABLE IF EXISTS "SKUs";

CREATE TABLE "SKUs" (
  "id" INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  "styleId" INTEGER NULL DEFAULT NULL,
  "size" VARCHAR NULL DEFAULT NULL,
  "quantity" INTEGER NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

-- ---
-- Table "styles"
--
-- ---

DROP TABLE IF EXISTS "styles";

CREATE TABLE "styles" (
  "id" INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  "productId" INTEGER NULL DEFAULT NULL,
  "name" VARCHAR NULL DEFAULT NULL,
  "sale_price" INTEGER NULL DEFAULT NULL,
  "original_price" INTEGER NULL DEFAULT NULL,
  "default_style" INTEGER NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

-- ---
-- Table "related"
--
-- ---

DROP TABLE IF EXISTS "related";

CREATE TABLE "related" (
  "id" INTEGER NULL AUTO_INCREMENT DEFAULT NULL,
  "current_product_id" INTEGER NULL DEFAULT NULL,
  "related_product_id" INTEGER NULL DEFAULT NULL,
  PRIMARY KEY ("id")
);

-- ---
-- Foreign Keys
-- ---

ALTER TABLE "Features" ADD FOREIGN KEY (product_id) REFERENCES "Product" ("id");
ALTER TABLE "Photos" ADD FOREIGN KEY (styleId) REFERENCES "styles" ("id");
ALTER TABLE "SKUs" ADD FOREIGN KEY (styleId) REFERENCES "styles" ("id");
ALTER TABLE "styles" ADD FOREIGN KEY (productId) REFERENCES "Product" ("id");
ALTER TABLE "related" ADD FOREIGN KEY (current_product_id) REFERENCES "Product" ("id");


-- --
-- Import CSV Files into Tables
-- --

copy product(id,name,slogan,description,category,default_price)
from "/Users/seijimatsumoto/Documents/Hack Reactor/RFE4/SDC/Products-API/data/product.csv"
DELIMITER ","
CSV HEADER;

copy related(id,current_product_id,related_product_id)
from "/Users/seijimatsumoto/Documents/Hack Reactor/RFE4/SDC/Products-API/data/related.csv"
DELIMITER ","
CSV HEADER;

copy features(id,product_id,feature,value)
from "/Users/seijimatsumoto/Documents/Hack Reactor/RFE4/SDC/Products-API/data/features.csv"
DELIMITER ","
CSV HEADER;

copy styles(id,productId,name,sale_price,original_price,default_style)
from "/Users/seijimatsumoto/Documents/Hack Reactor/RFE4/SDC/Products-API/data/styles.csv"
DELIMITER ","
CSV HEADER;

copy skus(id,styleId,size,quantity)
from "/Users/seijimatsumoto/Documents/Hack Reactor/RFE4/SDC/Products-API/data/skus.csv"
DELIMITER ","
CSV HEADER;

copy photos(id,styleId,url,thumbnail_url)
from "/Users/seijimatsumoto/Documents/Hack Reactor/RFE4/SDC/Products-API/data/photos.csv"
DELIMITER ","
CSV HEADER;

CREATE INDEX product_id_index ON product (id);
CREATE INDEX features_product_id_index ON features (product_id);
CREATE INDEX photos_styleid_index ON photos (styleid);
CREATE INDEX skus_styleid_index ON skus (styleid);
CREATE INDEX current_product_id_index ON related (current_product_id);
