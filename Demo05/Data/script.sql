create extension if not exists vector;

CREATE TABLE recomendations (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    category TEXT NOT NULL,
    embedding vector(1024) NOT NULL
);

CREATE INDEX idx_recomendations ON recomendations USING HNSW (embedding vector_l2_ops);


CREATE TABLE products (
      id SERIAL PRIMARY KEY,
      title TEXT NOT NULL,
      category TEXT NOT NULL,
      summary TEXT NOT NULL,
      description TEXT NOT NULL
);

insert into products values(1, 'Brazilian Coffee', 'robust', 'One of the most popular coffees in the world', 'Brazilian coffee is famous for its balanced and approachable flavors. Most Brazilian beans lean towards a mild, nutty taste with hints of chocolate. Some regions, like Minas Gerais, produce coffee with a sweet, nutty profile, while areas like Bahia are known for their fruity, lively notes.')

INSERT INTO products (id, title, category, summary, description) VALUES
    (2, 'Colombian Coffee', 'robust', 'Known for its balanced, smooth flavor and rich aroma', 'Colombian coffee is celebrated for its well-rounded flavor profile. It often features a smooth, medium body with a bright acidity and notes of citrus or red berries. The country''s diverse geography allows for a wide range of flavor nuances, from the caramel sweetness of the Antioquia region to the vibrant fruitiness of Huila.');

INSERT INTO products (id, title, category, summary, description) VALUES
    (3, 'Ethiopian Yirgacheffe', 'robust', 'A floral and citrusy coffee with a light body', 'Yirgacheffe coffee is a true gem of the coffee world. It is a wet-processed coffee with a distinctively clean, light body and a tea-like quality. Its flavor notes are predominantly floral, often with jasmine and bergamot, and a bright, citrusy acidity. It is known for its delicate and complex character.');

INSERT INTO products (id, title, category, summary, description) VALUES
    (4, 'Kenyan AA', 'soft', 'A vibrant coffee with bold fruit and wine notes', 'Kenyan coffee is highly sought after for its complex and lively flavor. The AA grade indicates a large bean size, often associated with higher quality. This coffee is known for its bright, sparkling acidity, full body, and rich, wine-like flavors, including notes of blackcurrant, tomato, and citrus. It has a powerful and memorable taste.');

INSERT INTO products (id, title, category, summary, description) VALUES
    (5, 'Sumatra Mandheling', 'soft', 'A full-bodied and earthy coffee from Indonesia', 'Sumatra Mandheling is renowned for its low acidity and heavy, syrupy body. This coffee has a unique flavor profile that is earthy and rustic, often with notes of chocolate, tropical fruit, and a distinct forest floor aroma. It is often wet-hulled, a process that gives it a signature earthy, spicy character and a smooth finish.');

INSERT INTO products (id, title, category, summary, description) VALUES
    (6, 'Costa Rican Tarrazu', 'intense', 'A clean, crisp coffee with a classic balance', 'Tarrazu coffee is a high-altitude bean from Costa Rica, known for its superb quality and clean taste. It has a medium body, a delicate, bright acidity, and a smooth, mellow finish. Flavor notes typically include brown sugar, citrus, and hints of tropical fruit. It is a quintessential Central American coffee.');

INSERT INTO products (id, title, category, summary, description) VALUES
    (7, 'Guatemalan Antigua', 'soft', 'A full-bodied coffee with a smoky, chocolatey flavor', 'Antigua coffee from Guatemala is grown in a volcanic region, which contributes to its rich, full-bodied character. It has a high-quality reputation, offering a complex flavor profile with notes of chocolate, spice, and a subtle smoky aroma. The acidity is bright and pleasant, and the finish is often spicy and prolonged.');

INSERT INTO products (id, title, category, summary, description) VALUES
    (8, 'Jamaican Blue Mountain', 'robust', 'One of the world''s most rare and expensive coffees', 'Jamaican Blue Mountain coffee is famous for its mild flavor and lack of bitterness. It has a well-balanced body, a clean, sweet taste, and a very smooth finish. Its flavor profile is often described as having notes of nuts and herbs, with a subtle sweetness. It is considered a premium, luxury coffee.');

INSERT INTO products (id, title, category, summary, description) VALUES
    (9, 'Hawaiian Kona', 'intense', 'A rare, delicate coffee with a smooth, bright flavor', 'Kona coffee is grown on the slopes of the Mauna Loa and Hualalai volcanoes in Hawaii. It is a smooth, light-bodied coffee with a complex aroma and a crisp, clean taste. Its flavor profile includes notes of milk chocolate, nuts, and fruit, with a low acidity and a sweet finish. It is prized for its rarity and consistent quality.');

INSERT INTO products (id, title, category, summary, description) VALUES
    (10, 'Vietnamese Robusta', 'intense', 'A strong, bold coffee with a high caffeine content', 'Robusta coffee from Vietnam is known for its powerful, full-bodied taste and is a staple in Vietnamese coffee culture. It has a nutty and chocolatey profile, with notes of caramel and a strong, bitter aftertaste. It is often prepared using a phin filter, resulting in a thick and intense brew, commonly served with sweetened condensed milk.');

INSERT INTO products (id, title, category, summary, description) VALUES
    (11, 'Tanzanian Peaberry', 'arabic', 'A bright, lively coffee with citrus and berry notes', 'Tanzanian Peaberry is a unique coffee where the cherry produces a single, round bean instead of two flat ones. This is believed to concentrate the flavor. The resulting cup has a rich, medium body with a vibrant, wine-like acidity. Flavor notes often include citrus, blackcurrant, and hints of cedar, offering a bright and sophisticated experience.');

INSERT INTO products (id, title, category, summary, description) VALUES
    (12, 'Yemeni Mokha', 'arabic', 'One of the oldest and most historical coffees', 'Yemeni Mokha coffee has a distinct, rustic flavor profile. It has a full body and a deep, complex taste with notes of chocolate, fruit, and spice. The processing method, drying the cherries on rooftops, gives it a unique, earthy quality. It is known for its wild, untamed flavor and rich history, named after the port of Mokha.');

INSERT INTO products (id, title, category, summary, description) VALUES
    (13, 'Burundi Coffee', 'arabic', 'A sweet and floral coffee with a clean finish', 'Burundi coffee is gaining popularity for its excellent quality. Grown at high altitudes, it has a clean and bright profile. The flavor often includes notes of floral honey, citrus, and red berries, with a delicate acidity and a medium body. It offers a sweet and pleasant cup that is very approachable.');

INSERT INTO products (id, title, category, summary, description) VALUES
    (14, 'Ethiopian Harrar', 'arabic', 'A wild, fruit-forward coffee with a complex profile', 'Ethiopian Harrar is a dry-processed coffee with a strong, fruity flavor. It has a heavy body and a low acidity, with a taste that is often described as wild and complex. Common notes include blueberries, cocoa, and spices. It is a bold and rustic coffee that stands out with its unique, naturally fruity taste.');

INSERT INTO products (id, title, category, summary, description) VALUES
    (15, 'Indian Monsooned Malabar', 'intense', 'A coffee with a unique, earthy, and nutty character', 'Monsooned Malabar coffee is a specialty of the Malabar Coast of India. The beans are exposed to monsoon winds and rain for several months, which causes them to swell and lose their original acidity. The resulting coffee is very low in acidity with a unique, heavy body and a pungent, earthy, and nutty flavor.');

